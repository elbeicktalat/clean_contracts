//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:flutter/widgets.dart' show Widget;
import 'package:get/get.dart' show GetPage;

typedef WidgetBuilder = Widget Function();

abstract class Page<T> extends GetPage<T> {
  Page({
    required super.name,
    required WidgetBuilder view,
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
    super.middlewares,
    super.unknownRoute,
    super.arguments,
    super.showCupertinoParallax,
    super.preventDuplicates,
    List<Page>? subPages,
  }) : super(
          page: view,
          children: subPages = const <Page>[],
        );
}
