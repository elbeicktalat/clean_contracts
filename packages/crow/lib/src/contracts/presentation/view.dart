//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart'
    show BaseViewModel, BaseViewMixin;
import 'package:flutter/widgets.dart' show optionalTypeArgs;
import 'package:get/get.dart' show GetView;

@optionalTypeArgs
abstract class View<T extends BaseViewModel> extends GetView<T>
    with BaseViewMixin<T> {
  const View({super.key});
}
