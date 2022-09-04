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

class HashCodeGenerator extends GeneratorForAnnotation<HashCode> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final List<DartObject>? fieldsToExclude =
        annotation.objectValue.getField('exclude')?.toListValue();

    final StringBuffer buffer = StringBuffer();
    final HashCodeVisitor visitor = HashCodeVisitor(fieldsToExclude);
    element.visitChildren(visitor);

    buffer.writeln(
      'extension _\$${visitor.className}HashCodeExtension on ${visitor.className} {',
    );

    buffer.writeln('int \$hashCode() =>');
    for (int i = 0; i < visitor.fields.length; i++) {
      final String fieldName = visitor.fields.keys.elementAt(i);
      buffer.write('$fieldName.hashCode');
      if (i != visitor.fields.length - 1) {
        buffer.write('^');
      } else {
        buffer.write(';');
      }
    }

    buffer.writeln('}');
    String result = buffer.toString();
    buffer.clear();
    return result;
  }
}

class HashCodeVisitor extends SimpleElementVisitor<void> {
  HashCodeVisitor(this.fieldsToExclude);

  List<DartObject>? fieldsToExclude;

  late DartType className;
  final Map<String, DartType> fields = <String, DartType>{};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element.type;

    // always remove hashCode.
    fields.remove('hashCode');
    if (fieldsToExclude != null) {
      for (final DartObject field in fieldsToExclude!) {
        fields.remove(field.toStringValue());
      }
    }
  }
}
