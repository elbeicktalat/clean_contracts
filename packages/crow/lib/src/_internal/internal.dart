//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

library internal;

import 'dart:io' show Platform;

import 'package:crow/src/utils/screen_settings.dart';
import 'package:crow/src/utils/screen_type.dart';
import 'package:flutter/widgets.dart'
    show protected, mustCallSuper, BuildContext, Widget, MediaQuery;
import 'package:get_it/get_it.dart' show GetIt;

part 'screen/responsive_screen.dart';
part 'screen/screen.dart';
part 'view/view.dart';
part 'view_model/base_view_model.dart';
