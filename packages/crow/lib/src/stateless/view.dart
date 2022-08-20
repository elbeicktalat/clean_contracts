//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart' show BaseViewMixin;
import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/material.dart' show StatelessWidget;

/// The StatelessWidget mixin.
mixin ViewMixin<T extends ViewModel> on StatelessWidget, BaseViewMixin<T> {}

/// The [StatelessWidget] which comes with viewModel instance
/// and some other utilities.
///
/// You must define the type parameter in order to get the expected ViewModel.
abstract class View<T extends ViewModel> extends StatelessWidget
    with BaseViewMixin<T>, ViewMixin<T> {
  ///
  const View({final super.key});
}
