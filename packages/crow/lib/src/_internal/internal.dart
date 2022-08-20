//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

library internal;

import 'dart:io' show Platform;

import 'package:crow/src/utils/screen_settings.dart';
import 'package:crow/src/utils/screen_type.dart';
import 'package:crow/src/view_model/state_view_model.dart';
import 'package:flutter/foundation.dart'
    show DiagnosticPropertiesBuilder, DiagnosticsProperty;
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        MediaQuery,
        State,
        StatefulWidget,
        Widget,
        mustCallSuper,
        protected;
import 'package:get_it/get_it.dart' show GetIt;

part 'src/base_view.dart';
part 'src/base_view_model.dart';
part 'src/screen/base_screen.dart';
part 'src/screen/responsive_screen.dart';
part 'src/state/screen_state.dart';
part 'src/state/view_state.dart';
