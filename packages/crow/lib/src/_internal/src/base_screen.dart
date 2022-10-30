//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

part of internal;

/// The base mixin for the public [Screen].
///
/// This mixin need a type parameter of [BaseViewModel].
@internal
mixin BaseScreenMixin<T extends BaseViewModel>
    on GetResponsiveView<T>, BaseViewMixin<T> {
  @override
  BuildContext get context => screen.context;

  @protected
  Widget build(BuildContext context) {
    screen.context = context;
    viewModel._context = context;
    Widget? widget;
    if (alwaysUseBuilder) {
      widget = builder();
      if (widget != null) return widget;
    }
    if (screen.isDesktop) {
      widget = desktop() ?? widget;
      if (widget != null) return widget;
    }
    if (screen.isTablet) {
      widget = tablet() ?? desktop();
      if (widget != null) return widget;
    }
    if (screen.isPhone) {
      widget = phone() ?? tablet() ?? desktop();
      if (widget != null) return widget;
    }
    return watch() ?? phone() ?? tablet() ?? desktop() ?? builder()!;
  }
}
