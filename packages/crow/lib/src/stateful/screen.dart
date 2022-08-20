//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart'
    show ScreenStateMixin, StateMixin, ResponsiveScreen;
import 'package:crow/src/utils/screen_settings.dart';
import 'package:crow/src/view_model/state_view_model.dart';
import 'package:flutter/widgets.dart' show State, StatefulWidget;

/// [ScreenState] is the implementation of [State].
///
/// Needs tow type parameters, the first is a subclass of [StatefulWidget]
/// and the second is a subclass of [StateViewModel].
abstract class ScreenState<T extends StatefulWidget, V extends StateViewModel>
    extends State<T> with StateMixin<T, V>, ScreenStateMixin<T, V> {
  ///
  ScreenState({
    this.alwaysUseBuilder = false,
    final ScreenSettings settings = const ScreenSettings(),
  }) : screen = ResponsiveScreen<V>(settings);

  @override
  final bool alwaysUseBuilder;

  @override
  final ResponsiveScreen<V> screen;
}
