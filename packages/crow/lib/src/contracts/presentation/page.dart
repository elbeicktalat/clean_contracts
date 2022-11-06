//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:get/get.dart' show GetPage;
import 'package:meta/meta.dart';

@optionalTypeArgs
abstract class Page<T> extends GetPage<T> {
  Page({
    required super.name,
    required super.page,
    super.title,
    super.participatesInRootNavigator,
    super.gestureWidth,
    super.maintainState,
    super.curve,
    super.alignment,
    super.parameters,
    super.opaque,
    super.transitionDuration,
    super.popGesture,
    super.binding,
    super.bindings,
    super.transition,
    super.customTransition,
    super.fullscreenDialog,
    super.children,
    super.middlewares,
    super.unknownRoute,
    super.arguments,
    super.showCupertinoParallax,
    super.preventDuplicates,
  });
}
