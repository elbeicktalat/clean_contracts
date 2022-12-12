//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crow_annotation/crow_annotation.dart';
import 'package:source_gen/source_gen.dart';

const String _bindingClassName = 'Binding';
const String _asField = 'as';
const String _tagField = 'tag';
const String _permanentField = 'permanent';
const String _strategyField = '_strategy';
const String _callDependenciesBeforeField = 'callDependenciesBefore';
const String _lazyPut = 'lazyPut';
const String _put = 'put';
const String _putAsync = 'putAsync';

class AutowiredGenerator extends GeneratorForAnnotation<Autowired> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final StringBuffer buffer = StringBuffer();
    final AutowiredVisitor visitor = AutowiredVisitor();
    element.visitChildren(visitor);

    final String? as = annotation.objectValue
        .getField(_asField)
        ?.toTypeValue()
        ?.getDisplayString(withNullability: false);

    final String? tag =
        annotation.objectValue.getField(_tagField)?.toStringValue();

    final String className = as != null
        ? '${as}$_bindingClassName'
        : '${visitor.className}$_bindingClassName';

    final _AutowiredStrategy? autowiredStrategy =
        annotation.objectValue.getField(_strategyField)?.toAutowiredStrategy();

    final bool callDependenciesBefore = annotation.objectValue
            .getField(_callDependenciesBeforeField)
            ?.toBoolValue() ??
        false;

    final bool? permanent =
        annotation.objectValue.getField(_permanentField)?.toBoolValue();

    late final String putKeyword;
    switch (autowiredStrategy) {
      case _AutowiredStrategy.lazy:
        putKeyword = _lazyPut;
        break;
      case _AutowiredStrategy.async:
        putKeyword = _putAsync;
        break;
      case _AutowiredStrategy.normal:
        putKeyword = _put;
        break;
      case null:
        break;
    }

    final List<Autowired?> autowireds = <Autowired?>[];
    for (int i = 0; i < visitor.parameters.length; i++) {
      final MapEntry<String, FieldElement> field =
          visitor.fields.entries.elementAt(i);
      final ParameterElement parameter = visitor.parameters[i];
      for (final ElementAnnotation meta in field.value.metadata) {
        if (field.value.type == parameter.type) {
          autowireds.add(meta.computeConstantValue()?.toAutowired());
        }
      }
    }

    _getImports(element, buffer, callDependenciesBefore, visitor);

    buffer.writeln('class $className extends $_bindingClassName {');
    buffer.writeln('@override');
    buffer.writeln('void dependencies() {');
    if (callDependenciesBefore) {
      for (final ParameterElement parameter in visitor.parameters) {
        buffer.writeln('${parameter.type}$_bindingClassName().dependencies();');
      }
    }

    if (as != null) {
      buffer.writeln('$putKeyword<${as}>(');
      buffer.write(_getPutCallback(visitor, autowireds, autowiredStrategy));
      if (permanent != null &&
          permanent != false &&
          autowiredStrategy != _AutowiredStrategy.lazy) {
        buffer.write('$_permanentField: $permanent,');
      }
      if (tag != null) {
        buffer.write("$_tagField: '$tag',");
      }
      buffer.writeln(');');
    } else {
      buffer.writeln('$putKeyword(');
      buffer.write(_getPutCallback(visitor, autowireds, autowiredStrategy));
      if (permanent != null &&
          permanent != false &&
          autowiredStrategy != _AutowiredStrategy.lazy) {
        buffer.write('$_permanentField: $permanent,');
      }
      if (tag != null) {
        buffer.write("$_tagField: '$tag',");
      }
      buffer.writeln(');');
    }

    buffer.writeln('}');
    buffer.writeln('}');

    final String result = buffer.toString();
    buffer.clear();
    return result;
  }

  void _getImports(Element element, StringBuffer buffer,
      bool callDependenciesBefore, AutowiredVisitor visitor) {
    final List<LibraryImportElement> imports =
        element.library?.libraryImports ?? <LibraryImportElement>[];

    imports.retainWhere((LibraryImportElement element) {
      return !(element.importedLibrary?.isDartCore ?? false) &&
          !(element.importedLibrary.isCrowAnnotation);
    });

    for (int index = 0; index < imports.length; index++) {
      final LibraryImportElement importElement = imports[index];
      if (index == 0) {
        buffer.writeln(
          getImport(
            importElement.librarySource.getPackageImportValue(),
          ),
        );
      }
      buffer.writeln(
        getImport(
          importElement.importedLibrary?.librarySource.getPackageImportValue(),
        ),
      );
    }

    if (callDependenciesBefore) {
      for (int i = 0; i < visitor.parameters.length; i++) {
        final ParameterElement parameter = visitor.parameters[i];

        final String typeName =
            parameter.type.getDisplayString(withNullability: false);

        final bool any = imports.any((LibraryImportElement e) => e
            .getDisplayString(withNullability: false)
            .contains(typeName.toLowerSnakeCase()));

        if (any) {
          String? firstWhere = imports
              .firstWhere((LibraryImportElement e) => e
                  .getDisplayString(withNullability: false)
                  .contains(typeName.toLowerSnakeCase()))
              .importedLibrary
              ?.librarySource
              .getPackageImportValue();

          buffer.writeln(
            getImport(
              '${firstWhere?.replaceAll('.dart', '')}.binding.dart',
            ),
          );
        }
      }
    }
  }

  String _getFinders(
    AutowiredVisitor visitor,
    List<Autowired?> autowireds,
  ) {
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < visitor.parameters.length; i++) {
      final ParameterElement parameter = visitor.parameters[i];
      Autowired? autowired;
      if (i < autowireds.length) {
        autowired = autowireds[i];
      }
      if (autowired != null && autowired.tag != null) {
        buffer.write(
          "find<${parameter.type}>($_tagField: '${autowired.tag}'),",
        );
      } else {
        buffer.write('find<${parameter.type}>(),');
      }
    }

    final String result = buffer.toString();
    buffer.clear();
    return result;
  }

  String _getPutCallback(
    AutowiredVisitor visitor,
    List<Autowired?> autowireds,
    _AutowiredStrategy? autowiredStrategy,
  ) {
    final StringBuffer buffer = StringBuffer();

    switch (autowiredStrategy) {
      case _AutowiredStrategy.lazy:
        buffer.writeln('() => ${visitor.className}(');
        buffer.write(_getFinders(visitor, autowireds));
        buffer.writeln('),');
        break;
      case _AutowiredStrategy.async:
        buffer.writeln('() => ${visitor.className}(');
        buffer.write(_getFinders(visitor, autowireds));
        buffer.writeln(').async(),');
        break;
      case _AutowiredStrategy.normal:
        buffer.writeln('${visitor.className}(');
        buffer.write(_getFinders(visitor, autowireds));
        buffer.writeln('),');
        break;
      case null:
        break;
    }

    final String result = buffer.toString();
    buffer.clear();
    return result;
  }
}

class AutowiredVisitor extends SimpleElementVisitor<void> {
  DartType? className;
  late List<ParameterElement> parameters = <ParameterElement>[];
  final Map<String, FieldElement> fields = <String, FieldElement>{};

  @override
  void visitConstructorElement(ConstructorElement element) {
    super.visitConstructorElement(element);
    className = element.type.returnType;
    parameters = element.enclosingElement3.unnamedConstructor?.parameters ??
        <ParameterElement>[];
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element;
  }
}

extension DartObjectExtemstion on DartObject {
  _AutowiredStrategy toAutowiredStrategy() {
    late _AutowiredStrategy strategy;
    final String? source = this.getField('_name')?.toStringValue();
    switch (source) {
      case 'lazy':
        strategy = _AutowiredStrategy.lazy;
        break;
      case 'async':
        strategy = _AutowiredStrategy.async;
        break;
      case 'normal':
        strategy = _AutowiredStrategy.normal;
        break;
    }
    return strategy;
  }

  Autowired toAutowired() {
    final _AutowiredStrategy? strategy =
        this.getField(_strategyField)?.toAutowiredStrategy();
    final String? tag = this.getField(_tagField)?.toStringValue();
    final Type? as = this.getField(_asField)?.toTypeValue().runtimeType;
    final bool callDependenciesBefore =
        this.getField(_callDependenciesBeforeField)?.toBoolValue() ?? false;
    final bool permanent =
        this.getField(_permanentField)?.toBoolValue() ?? false;

    late Autowired autowired;
    switch (strategy) {
      case _AutowiredStrategy.lazy:
        autowired = Autowired(
          as: as,
          tag: tag,
          callDependenciesBefore: callDependenciesBefore,
        );
        break;
      case _AutowiredStrategy.async:
        autowired = Autowired.async(
          as: as,
          tag: tag,
          callDependenciesBefore: callDependenciesBefore,
          permanent: permanent,
        );
        break;
      case _AutowiredStrategy.normal:
        autowired = Autowired.put(
          as: as,
          tag: tag,
          callDependenciesBefore: callDependenciesBefore,
          permanent: permanent,
        );
        break;
      case null:
        break;
    }

    return autowired;
  }
}

extension LibraryElementExtension on LibraryElement? {
  bool get isCrowAnnotation =>
      this
          ?.getDisplayString(withNullability: false)
          .contains('crow_annotation') ??
      false;
}

extension LibraryImportElementExtension on Source? {
  String? getPackageImportValue() {
    String? value = this.toString().replaceFirst('/', '');
    return 'package:${value.replaceAll('/lib', '')}';
  }
}

String getImport(String? value) => value != null ? "import '$value';" : '';

enum _AutowiredStrategy {
  lazy,
  async,
  normal,
}

extension StringExtension on String {
  List<String> toWords() => split(' ');

  String toLowerSnakeCase() {
    RegExp regExp = RegExp(r'(?<=[a-z])[A-Z]');
    final String firstChar = String.fromCharCode(runes.first);
    String result = this
        .replaceFirst(firstChar, firstChar.toLowerCase())
        .replaceAllMapped(regExp, (Match m) => ('_${m.group(0)}'))
        .toLowerCase();

    return result;
  }
}
