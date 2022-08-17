//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/base/screen.dart';
import 'package:crow/src/base/view.dart';
import 'package:crow/src/utils/screen_settings.dart';
import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/material.dart';

/// The [Screen] mixin of the [StatelessWidget].
mixin ScreenMixin<T extends ViewModel> on BaseScreenMixin<T>, StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    screen.context = context;
    viewModel.context = context;
    Widget? widget;
    if (!alwaysUseBuilder) {
      if (screen.isDesktop) {
        widget = desktop() ?? widget;
        if (widget != null) return widget;
      }
      if (screen.isTablet) {
        widget = tablet() ?? desktop();
        if (widget != null) return widget;
      }
      if (screen.isMobile) {
        widget = mobile() ?? tablet() ?? desktop();
        if (widget != null) return widget;
      }
      if (screen.isWatch) {
        widget = watch() ?? mobile() ?? tablet() ?? desktop();
        if (widget != null) return widget;
      }
    } else {
      widget = builder();
      if (widget != null) return widget;
    }
    assert(hasImplementation, 'Provide at least one implementation');
    return watch() ?? mobile() ?? tablet() ?? desktop() ?? builder()!;
  }
}

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
