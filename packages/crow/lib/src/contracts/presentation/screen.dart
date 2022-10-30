//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart'
    show BaseViewModel, BaseViewMixin, BaseScreenMixin;
import 'package:get/get.dart' show GetResponsiveView;
import 'package:meta/meta.dart';

@optionalTypeArgs
abstract class Screen<T extends BaseViewModel> extends GetResponsiveView<T>
    with BaseViewMixin<T>, BaseScreenMixin<T> {
  Screen({
    super.alwaysUseBuilder,
    super.settings,
    super.key,
  });
}
