//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart'
    show BaseScreenMixin, BaseViewMixin, ResponsiveScreen;
import 'package:crow/src/utils/screen_settings.dart';
import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/material.dart' show StatelessWidget;
import 'package:flutter/widgets.dart';

/// The [Screen] mixin of the [StatelessWidget].
mixin ScreenMixin<T extends ViewModel> on BaseScreenMixin<T>, StatelessWidget {}

/// The implementation version of the [StatelessWidget] and [ScreenMixin].
abstract class Screen<T extends ViewModel> extends StatelessWidget
    with BaseViewMixin<T>, BaseScreenMixin<T>, ScreenMixin<T> {
  ///
  Screen({
    final super.key,
    final this.alwaysUseBuilder = false,
    final ScreenSettings settings = const ScreenSettings(),
  }) : screen = ResponsiveScreen<T>(settings);

  @override
  final bool alwaysUseBuilder;

  @override
  final ResponsiveScreen<T> screen;
}
