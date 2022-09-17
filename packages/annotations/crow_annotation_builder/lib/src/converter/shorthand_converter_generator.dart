//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:crow_annotation/crow_annotation.dart';
import 'package:crow_annotation_builder/src/converter/converter_generator.dart';
import 'package:source_gen/source_gen.dart';

const String _converterName = 'Converter';
const String _jsonSerializableName = 'JsonSerializable';

class ShorthandConverterGenerator extends GeneratorForAnnotation<Converter> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final StringBuffer buffer = StringBuffer();
    final ConverterVisitor visitor = ConverterVisitor();
    element.visitChildren(visitor);

    late bool hasJsonSerializable;
    bool? createFromJson;
    bool? createToJson;
    String? converteeName;
    String? fromObjectName;
    String? toObjectName;
    for (final ElementAnnotation meta in element.metadata) {
      if (meta.computeConstantValue()?.type?.toString() == _converterName) {
        converteeName = meta
            .computeConstantValue()
            ?.getField('objectType')
            ?.toTypeValue()
            .toString()
            .replaceAll('*', '');

        fromObjectName = meta
            .computeConstantValue()
            ?.getField('fromObject')
            ?.toStringValue();

        toObjectName =
            meta.computeConstantValue()?.getField('toObject')?.toStringValue();
      }
      if (meta.computeConstantValue()?.type?.toString() ==
          _jsonSerializableName) {
        hasJsonSerializable = true;

        createFromJson = meta
            .computeConstantValue()
            ?.getField('createFactory')
            ?.toBoolValue();

        createToJson = meta
            .computeConstantValue()
            ?.getField('createToJson')
            ?.toBoolValue();
      } else {
        hasJsonSerializable = false;
      }
    }

    buffer.writeln(
      'extension ${visitor.className}$_converterName on ${visitor.className} {',
    );

    if (converteeName != null) {
      final String instanceConverteeName = converteeName.toLowerCase();
      final String fromMethodName =
          fromObjectName != null ? fromObjectName : 'from$converteeName';
      final String toMethodName =
          toObjectName != null ? toObjectName : 'to$converteeName';

      buffer.writeln(
        'static ${visitor.className} $fromMethodName($converteeName $instanceConverteeName) => _\$${visitor.className}From$converteeName($instanceConverteeName);',
      );
      buffer.writeln('');
      buffer.writeln(
        '$converteeName $toMethodName() => _\$${visitor.className}To$converteeName(this);',
      );
    }

    buffer.writeln('');

    if (hasJsonSerializable) {
      if (createFromJson ?? true) {
        buffer.writeln(
          'static ${visitor.className} fromJson(Map<String, dynamic> json) => _\$${visitor.className}FromJson(json);',
        );
      }
      buffer.writeln('');
      if (createToJson ?? true) {
        buffer.writeln(
          'Map<String, dynamic> toJson() => _\$${visitor.className}ToJson(this);',
        );
      }
    }

    buffer.writeln('}');
    final String result = buffer.toString();
    buffer.clear();
    return result;
  }
}
