//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crow_annotation/crow_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ToStringGenerator extends GeneratorForAnnotation<ToString> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final List<DartObject>? fieldsToExclude =
        annotation.objectValue.getField('exclude')?.toListValue();

    final bool? includePrivets =
        annotation.objectValue.getField('includePrivets')?.toBoolValue();

    final StringBuffer buffer = StringBuffer();
    final ToStringVisitor visitor = ToStringVisitor(
      fieldsToExclude,
      includePrivets,
    );
    element.visitChildren(visitor);

    bool hasSuperAnnotation = false;
    for (final ElementAnnotation meta in element.metadata) {
      if (meta.computeConstantValue()?.type?.toString() == 'Super') {
        hasSuperAnnotation = true;
      }
    }

    String targetName = visitor.className.toString();
    if (hasSuperAnnotation) {
      targetName = '_${visitor.className}';
    }

    buffer.writeln(
      'extension _\$${visitor.className}ToStringExtension on $targetName {',
    );

    buffer.write('String \$toString() => \'');
    buffer.write('${visitor.className}{');
    if (hasSuperAnnotation) {
      for (int i = 0; i < visitor.parameters.length; i++) {
        final String paramName = visitor.parameters.keys.elementAt(i);

        buffer.write('$paramName: \$$paramName');
        if (i != visitor.parameters.length - 1) {
          buffer.write(', ');
        }
      }
    }
    for (int i = 0; i < visitor.fields.length; i++) {
      final String fieldName = visitor.fields.keys.elementAt(i);
      buffer.write('$fieldName: \$$fieldName');
      if (i != visitor.fields.length - 1) {
        buffer.write(', ');
      }
    }
    buffer.write('}');
    buffer.write('\';');

    buffer.writeln('}');
    String result = buffer.toString();
    buffer.clear();
    return result;
  }
}

class ToStringVisitor extends SimpleElementVisitor<void> {
  ToStringVisitor(this.fieldsToExclude, this.includePrivets);

  bool? includePrivets;
  List<DartObject>? fieldsToExclude;

  late DartType className;
  final Map<String, DartType> parameters = <String, DartType>{};
  final Map<String, DartType> fields = <String, DartType>{};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
    getParameters(element);
  }

  void getParameters(ConstructorElement element) {
    if (element.enclosingElement3.unnamedConstructor?.parameters != null) {
      List<ParameterElement> params =
          element.enclosingElement3.unnamedConstructor!.parameters;

      if (!includePrivets!) {
        for (final ParameterElement param in params) {
          if (!param.isPrivate) {
            parameters[param.name] = param.type;
          }
        }
      } else {
        for (final ParameterElement param in params) {
          parameters[param.name] = param.type;
        }
      }

      if (fieldsToExclude != null) {
        for (final DartObject param in fieldsToExclude!) {
          parameters.remove(param.toStringValue());
        }
      }
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (!includePrivets!) {
      if (!element.isPrivate) {
        fields[element.name] = element.type;
      }
    } else {
      fields[element.name] = element.type;
    }

    // always remove hashCode.
    fields.remove('hashCode');
    if (fieldsToExclude != null) {
      for (final DartObject field in fieldsToExclude!) {
        fields.remove(field.toStringValue());
      }
    }
  }
}
