//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:crow_annotation/crow_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ConvertGenerator extends GeneratorForAnnotation<Convert> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final ConvertVisitor visitor = ConvertVisitor();
    final StringBuffer buffer = StringBuffer();

    final String className = element.name!;

    buffer.writeln(
      '/// Returns an object of the annotated class, it gets it\'s value from the target convert.',
    );
    buffer.writeln(
      _generateFromObject(element, annotation, visitor, className),
    );
    buffer.writeln(
      '/// Returns an object of the target convert class, it gets it\'s value from the annotated class.',
    );
    buffer.writeln(
      _generateToObject(element, annotation, visitor, className),
    );

    final String result = buffer.toString();
    buffer.clear();

    return result;
  }

  String _generateFromObject(
    Element element,
    ConstantReader annotation,
    ConvertVisitor visitor,
    String className,
  ) {
    final StringBuffer functionBuffer = StringBuffer();
    element.visitChildren(visitor);

    // target info
    final String objectType =
        '${annotation.objectValue.getField('objectType')?.toTypeValue()}'
            .replaceAll('*', '');

    functionBuffer.writeln(
      function(
        returnType: className,
        name: '\$${className}From$objectType',
        params: '$objectType instance',
        isPrivet: true,
        body: returnBody(
          className,
          'instance',
          visitor.parameters,
        ),
      ),
    );

    String result = functionBuffer.toString();
    functionBuffer.clear();
    return result;
  }

  String _generateToObject(
    Element element,
    ConstantReader annotation,
    ConvertVisitor visitor,
    String className,
  ) {
    final StringBuffer buffer = StringBuffer();
    element.visitChildren(visitor);

    // target info
    final String objectType =
        '${annotation.objectValue.getField('objectType')?.toTypeValue()}'
            .replaceAll('*', '');

    buffer.writeln(
      function(
        returnType: objectType,
        name: '\$${className}To$objectType',
        params: '$className instance',
        isPrivet: true,
        body: returnBody(
          objectType,
          'instance',
          visitor.parameters,
        ),
      ),
    );

    String result = buffer.toString();
    buffer.clear();
    return result;
  }
}

String function({
  required String returnType,
  required String name,
  required String body,
  String? params,
  bool isPrivet = false,
}) {
  StringBuffer buffer = StringBuffer();

  buffer.writeln('$returnType ${isPrivet ? '_' : ''}$name($params) {');
  buffer.writeln(body);
  buffer.writeln('}');

  String result = buffer.toString();
  buffer.clear();
  return result;
}

String returnBody(
  String objectType,
  String instance,
  List<ParameterElement> parameters,
) {
  final StringBuffer buffer = StringBuffer();

  buffer.writeln('return ${objectType}(');
  for (final ParameterElement param in parameters) {
    buffer.writeln(
      '${param.isNamed ? '${param.name}:' : ''} $instance.${param.name},',
    );
  }
  buffer.writeln(');');
  final String result = buffer.toString();
  buffer.clear();

  return result;
}

class ConvertVisitor extends SimpleElementVisitor<void> {
  DartType? className;
  late Map<String, DartType> fields = <String, DartType>{};
  late List<ParameterElement> parameters = <ParameterElement>[];
  late List<TypeParameterElement> typeParams = <TypeParameterElement>[];

  @override
  void visitConstructorElement(ConstructorElement element) {
    super.visitConstructorElement(element);
    className = element.type.returnType;
    parameters = element.enclosingElement3.unnamedConstructor?.parameters ??
        <ParameterElement>[];
  }

  @override
  void visitFieldElement(FieldElement element) {
    super.visitFieldElement(element);
    fields[element.name] = element.type;
  }
}
