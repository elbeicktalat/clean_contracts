//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:crow_annotation/crow_annotation.dart';
import 'package:crow_annotation_builder/src/utils.dart';
import 'package:source_gen/source_gen.dart';

const String _annotationName = 'Converter';

class ConverterGenerator extends GeneratorForAnnotation<Converter> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final ConverterVisitor visitor = ConverterVisitor();
    final ConverterVisitor visitor2 = ConverterVisitor();
    final StringBuffer buffer = StringBuffer();

    final String className = element.name!;

    // target info
    final String objectType =
        '${annotation.objectValue.getField('objectType')?.toTypeValue()}'
            .replaceAll('*', '');

    Element? element2;
    for (final ElementAnnotation meta in element.metadata) {
      if (meta.computeConstantValue()?.type.toString() == _annotationName) {
        element2 = meta
            .computeConstantValue()
            ?.getField('objectType')
            ?.toTypeValue()
            ?.element2;
      }
    }

    element.visitChildren(visitor);
    element2?.visitChildren(visitor2);

    if (className != objectType) {
      buffer.writeln(
        '/// Returns an object of the annotated class, it gets it\'s value from the target convert.',
      );
      buffer.writeln(
        _generateFromObject(
          visitor,
          visitor2,
          className,
          objectType,
        ),
      );
      buffer.writeln(
        '/// Returns an object of the target convert class, it gets it\'s value from the annotated class.',
      );
      buffer.writeln(
        _generateToObject(
          visitor,
          visitor2,
          className,
          objectType,
        ),
      );

      final String result = buffer.toString();
      buffer.clear();

      return result;
    } else {
      throw CrowLog.error(
        'It does\'t make any sense converting the same object!\n'
        'Annotated class: [$className]\n'
        'Subject: [$objectType]',
      );
    }
  }

  String _generateFromObject(
    ConverterVisitor visitor,
    ConverterVisitor visitor2,
    String className,
    String objectType,
  ) {
    final StringBuffer functionBuffer = StringBuffer();

    functionBuffer.writeln(
      function(
        returnType: className,
        name: '\$${className}From$objectType',
        params: '$objectType instance',
        isPrivet: true,
        body: _generateFromObjectBody(
          className,
          'instance',
          visitor.parameters,
          visitor2.parameters,
        ),
      ),
    );

    String result = functionBuffer.toString();
    functionBuffer.clear();
    return result;
  }

  String _generateToObject(
    ConverterVisitor visitor,
    ConverterVisitor visitor2,
    String className,
    String objectType,
  ) {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln(
      function(
        returnType: objectType,
        name: '\$${className}To$objectType',
        params: '$className instance',
        isPrivet: true,
        body: _generateToObjectBody(
          objectType,
          'instance',
          visitor2.parameters,
          visitor.parameters,
        ),
      ),
    );

    String result = buffer.toString();
    buffer.clear();
    return result;
  }
}

String _generateFromObjectBody(
  String returnType,
  String instance,
  List<ParameterElement> parameters,
  List<ParameterElement> targetParameters,
) {
  final StringBuffer buffer = StringBuffer();
  final ConverterVisitor visitor = ConverterVisitor();

  buffer.writeln('return ${returnType}(');
  for (int i = 0; i < parameters.length; i++) {
    final ParameterElement param = parameters[i];
    final ParameterElement param2 = targetParameters[i];

    final Element? paramElement = param.type.element2;
    paramElement?.visitChildren(visitor);

    String? fromObject;
    if (paramElement?.metadata != null) {
      for (final ElementAnnotation meta in paramElement!.metadata) {
        if (meta.computeConstantValue()?.type.toString() == _annotationName) {
          fromObject = meta
              .computeConstantValue()
              ?.getField('fromObject')
              ?.toStringValue();
        }
      }
    }

    final List<String> fromConstructors = <String>[];

    late String parsedParameter;
    late String parsedParameter2;
    for (ConstructorElement constructor in visitor.constructors) {
      final String constructorWithOutFrom =
          constructor.name.replaceAll('from', '');

      if (param.declaration.type.isDartCoreList) {
        param2.type.toString().replaceAll('List', '');
        parsedParameter = '${param2.type}'
            .replaceAll('List', '')
            .replaceAll('<', '')
            .replaceAll('>', '');

        parsedParameter2 = '${param.type}'
            .replaceAll('List', '')
            .replaceAll('<', '')
            .replaceAll('>', '');

        if (constructor.name.contains('from')) {
          fromConstructors.add('${constructor.name}$parsedParameter');
        }
      }

      if (fromObject != null) {
        fromConstructors.add(fromObject);
      } else if (constructor.name.contains('from') &&
          constructorWithOutFrom == '${param2.type}') {
        fromConstructors.add(constructor.name);
      }
    }

    if (fromConstructors.isNotEmpty) {
      if (param.declaration.type.isDartCoreList) {
        final String value =
            '$instance.${param2.name}.map((e) => ${parsedParameter2}.${fromConstructors.first}(e)).toList(),';
        if (param.isNamed) {
          buffer.writeln(
            namedParameter(
              '${param.name}',
              value,
            ),
          );
        } else {
          buffer.writeln(value);
        }
      } else {
        if (param.isNamed) {
          buffer.writeln(
            namedParameter(
              '${param.name}',
              '${paramElement?.name}.${fromConstructors.first}(',
            ),
          );
        } else {
          buffer.writeln(
            parameter('${paramElement?.name}.${fromConstructors.first}('),
          );
        }
        buffer.write(
          parameter('$instance.${param2.name}'),
        );
        buffer.writeln('${'),'}');
      }
    } else {
      if (param.isNamed) {
        buffer.writeln(
          namedParameter(param.name, '$instance.${param.name},'),
        );
      } else {
        buffer.writeln(
          parameter('$instance.${param.name},'),
        );
      }
    }
  }
  buffer.writeln(');');
  final String result = buffer.toString();
  buffer.clear();

  return result;
}

String _generateToObjectBody(
  String returnType,
  String instance,
  List<ParameterElement> parameters,
  List<ParameterElement> targetParameters,
) {
  final StringBuffer buffer = StringBuffer();
  final ConverterVisitor visitor = ConverterVisitor();

  buffer.writeln('return ${returnType}(');
  for (int i = 0; i < parameters.length; i++) {
    final ParameterElement param = parameters[i];
    final ParameterElement param2 = targetParameters[i];

    final Element? paramElement = param2.type.element2;
    paramElement?.visitChildren(visitor);

    String? toObject;
    if (paramElement?.metadata != null) {
      for (final ElementAnnotation meta in paramElement!.metadata) {
        if (meta.computeConstantValue()?.type.toString() == _annotationName) {
          toObject = meta
              .computeConstantValue()
              ?.getField('toObject')
              ?.toStringValue();
        }
      }
    }

    final List<String> toObjectMethods = <String>[];

    late String parsedParameter2;
    for (final MethodElement method in visitor.methods) {
      final String methodWithoutTo = method.name.replaceAll('to', '');

      if (param.declaration.type.isDartCoreList) {
        param2.type.toString().replaceAll('List', '');

        parsedParameter2 = '${param.type}'
            .replaceAll('List', '')
            .replaceAll('<', '')
            .replaceAll('>', '');

        toObjectMethods.add('to$parsedParameter2');
      }

      if (toObject != null) {
        toObjectMethods.add(toObject);
      } else if (method.name.contains('to') &&
          methodWithoutTo == '${param.type}') {
        toObjectMethods.add(method.name);
      }
    }

    if (toObjectMethods.isNotEmpty) {
      if (param.declaration.type.isDartCoreList) {
        final String value =
            '$instance.${param2.name}.map((e) => e.${toObjectMethods.first}()).toList(),';
        if (param.isNamed) {
          buffer.writeln(
            namedParameter(
              param.name,
              value,
            ),
          );
        } else {
          buffer.writeln(value);
        }
      } else {
        if (param.isNamed) {
          buffer.writeln(
            namedParameter(
              param.name,
              '$instance.${param2.name}.${toObjectMethods.first}(),',
            ),
          );
        } else {
          buffer.writeln(
            parameter(
              '$instance.${param2.name}.${toObjectMethods.first}(),',
            ),
          );
        }
      }
    } else {
      if (param.isNamed) {
        buffer.writeln(
          namedParameter(param.name, '$instance.${param.name},'),
        );
      } else {
        buffer.writeln(
          parameter('$instance.${param.name},'),
        );
      }
    }
  }
  buffer.writeln(');');
  final String result = buffer.toString();
  buffer.clear();

  return result;
}

class ConverterVisitor extends SimpleElementVisitor<void> {
  DartType? className;
  late Map<String, DartType> fields = <String, DartType>{};
  late List<ParameterElement> parameters = <ParameterElement>[];
  late List<ConstructorElement> constructors = <ConstructorElement>[];
  late List<MethodElement> methods = <MethodElement>[];

  @override
  void visitConstructorElement(ConstructorElement element) {
    super.visitConstructorElement(element);
    className = element.type.returnType;
    constructors = element.enclosingElement3.constructors;
    parameters = element.enclosingElement3.unnamedConstructor?.parameters ??
        <ParameterElement>[];
    methods = element.enclosingElement3.methods;
  }

  @override
  void visitFieldElement(FieldElement element) {
    super.visitFieldElement(element);
    fields[element.name] = element.type;
  }
}
