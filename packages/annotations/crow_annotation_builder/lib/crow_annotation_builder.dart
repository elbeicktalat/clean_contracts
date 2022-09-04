//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:build/build.dart';
import 'package:crow_annotation_builder/src/converter_generator.dart';
import 'package:crow_annotation_builder/src/equals_generator.dart';
import 'package:crow_annotation_builder/src/hash_code_generator.dart';
import 'package:crow_annotation_builder/src/to_string_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder converterBuilder(BuilderOptions options) =>
    SharedPartBuilder(<ConverterGenerator>[ConverterGenerator()], 'converter');

Builder toStringBuilder(BuilderOptions options) =>
    SharedPartBuilder(<ToStringGenerator>[ToStringGenerator()], 'toString');

Builder equalsBuilder(BuilderOptions options) =>
    SharedPartBuilder(<EqualsGenerator>[EqualsGenerator()], 'equals');

Builder hashCodeBuilder(BuilderOptions options) =>
    SharedPartBuilder(<HashCodeGenerator>[HashCodeGenerator()], 'hashCode');
