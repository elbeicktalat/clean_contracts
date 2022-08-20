//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart' show BaseViewMixin;
import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/widgets.dart' show StatelessWidget, optionalTypeArgs;

/// The [StatelessWidget] which comes with viewModel instance
/// and some other utilities.
///
/// This Widget dose accept a type parameter to allows
/// concrete [ViewModel] access. If nothing is specified than the [viewModel]
/// instance is a [ViewModel] instance.
@optionalTypeArgs
abstract class View<T extends ViewModel> extends StatelessWidget
    with BaseViewMixin<T> {
  /// The const contracture of the [View].
  const View({final super.key});
}
