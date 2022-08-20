//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart'
    show BaseScreenMixin, BaseViewMixin, ResponsiveScreen;
import 'package:crow/src/utils/screen_settings.dart';
import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/widgets.dart' show StatelessWidget, optionalTypeArgs;

/// The responsive implementation version of [View].
///
/// This Widget dose accept a type parameter to allows
/// concrete [ViewModel] access. If nothing is specified than the [viewModel]
/// instance is a [ViewModel] instance.
@optionalTypeArgs
abstract class Screen<T extends ViewModel> extends StatelessWidget
    with BaseViewMixin<T>, BaseScreenMixin<T> {
  /// To make your own change pints just pass the new values
  /// to the [ScreenSettings]. The [alwaysUseBuilder] property
  /// dose overwrite the default getter if you don't reimplement it.
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
