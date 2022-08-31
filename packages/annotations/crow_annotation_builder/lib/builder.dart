//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:build/build.dart';
import 'package:crow_annotation_builder/src/multiplier_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder convertBuilder(BuilderOptions options) =>
    SharedPartBuilder(<ConvertGenerator>[ConvertGenerator()], 'convert');
