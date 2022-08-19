//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/base/screen.dart';
import 'package:crow/src/base/view.dart';
import 'package:crow/src/stateful/view.dart';
import 'package:crow/src/utils/screen_settings.dart';
import 'package:crow/src/view_model/state_view_model.dart';
import 'package:flutter/widgets.dart';

/// The Screen State mixin.
///
/// This allows the [StateViewModel] to deal with [State] methods.
mixin ScreenStateMixin<T extends StatefulWidget, V extends StateViewModel>
    on StateMixin<T, V>, BaseScreenMixin<V> {}

/// [ScreenState] is the implementation of [State].
///
/// Need tow type parameter the first is subclass of [StatefulWidget]
/// and the second is a subclass of [StateViewModel].
abstract class ScreenState<T extends StatefulWidget, V extends StateViewModel>
    extends State<T>
    with
        BaseViewMixin<V>,
        BaseScreenMixin<V>,
        StateMixin<T, V>,
        ScreenStateMixin<T, V> {
  ///
  ScreenState({
    final this.alwaysUseBuilder = false,
    final ScreenSettings settings = const ScreenSettings(),
  }) : screen = ResponsiveScreen<V>(settings);

  @override
  final bool alwaysUseBuilder;

  @override
  final ResponsiveScreen<V> screen;
}
