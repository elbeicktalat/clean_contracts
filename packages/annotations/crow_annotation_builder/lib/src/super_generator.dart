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

class SuperGenerator extends GeneratorForAnnotation<Super> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final StringBuffer buffer = StringBuffer();
    final SuperVisitor visitor = SuperVisitor();
    element.visitChildren(visitor);

    bool? isAbstract;
    bool? isImmutable;
    DartType? superType;
    Set<String?>? interfaces;
    Set<String?>? mixins;
    for (final ElementAnnotation meta in element.metadata) {
      final String? metaName = meta.computeConstantValue()?.type.toString();
      if (metaName == 'Immutable') {
        isImmutable = true;
      }

      if (metaName == 'Super') {
        isAbstract =
            meta.computeConstantValue()?.getField('isAbstract')?.toBoolValue();

        superType =
            meta.computeConstantValue()?.getField('superType')?.toTypeValue();

        interfaces = meta
            .computeConstantValue()
            ?.getField('interfaces')
            ?.toSetValue()
            ?.map((DartObject e) =>
                e.toTypeValue().toString().replaceAll('*', ''))
            .toSet();

        mixins = meta
            .computeConstantValue()
            ?.getField('mixins')
            ?.toSetValue()
            ?.map((DartObject e) =>
                e.toTypeValue().toString().replaceAll('*', ''))
            .toSet();
      }
    }

    if (isAbstract ?? false) {
      buffer.write('abstract ');
    }

    buffer.write('class _${visitor.className}');

    if (superType != null) {
      buffer.write(' extends $superType'.replaceAll('*', ''));
    }

    if (mixins != null) {
      buffer.write(' with ');
      for (int i = 0; i < mixins.length; i++) {
        final String? mixin = mixins.elementAt(i);
        if (mixin != null) {
          buffer.write('${mixin}');
        }
        if (i != mixins.length - 1) {
          buffer.write(',');
        }
      }
    }

    if (interfaces != null) {
      buffer.write(' implements ');
      for (int i = 0; i < interfaces.length; i++) {
        final String? interface = interfaces.elementAt(i);
        if (interface != null) {
          buffer.write('${interface} ');
        }
        if (i != interfaces.length - 1) {
          buffer.write(',');
        }
      }
    }

    buffer.writeln('{');

    buffer.writeln('_${visitor.className}(');
    for (final ParameterElement field in visitor.parameters) {
      buffer.writeln('this.${field.name},');
    }
    buffer.writeln(');');
    buffer.writeln('');

    for (final ParameterElement field in visitor.parameters) {
      if (isImmutable ?? false) {
        buffer.writeln('final ${field.type} ${field.name};');
      } else {
        buffer.writeln('${field.type} ${field.name};');
      }
    }

    for (final ElementAnnotation meta in element.metadata) {
      if (meta.computeConstantValue()?.type?.toString() == 'ToString') {
        buffer.writeln('');
        buffer.writeln('@override');
        buffer.writeln('String toString() => \$toString();');
      }
      if (isImmutable ?? false) {
        if (meta.computeConstantValue()?.type?.toString() == 'Equals') {
          buffer.writeln('');
          buffer.writeln('@override');
          buffer.writeln('bool operator ==(Object other) => \$equals(other);');
        }
        if (meta.computeConstantValue()?.type?.toString() == 'HashCode') {
          buffer.writeln('');
          buffer.writeln('@override');
          buffer.writeln('int get hashCode => \$hashCode();');
        }
      }
    }

    buffer.writeln('}');

    final String result = buffer.toString();
    buffer.clear();
    return result;
  }
}

class SuperVisitor extends SimpleElementVisitor<void> {
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

    // always remove hashCode.
    fields.remove('hashCode');
  }
}
