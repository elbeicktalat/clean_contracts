//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

part of internal;

/// The base mixin for every Screen.
mixin BaseScreenMixin<T extends BaseViewModel> on BaseViewMixin<T> {
  /// Get util info about the screen.
  @protected
  ResponsiveScreen<T> get screen;

  /// Force the usage of the [builder] methods.
  ///
  /// Override this to ignore other [builder]s.
  @protected
  bool get alwaysUseBuilder => false;

  /// {@macro crow.context}
  ///
  /// This is a shorthand for [screen.context].
  @override
  @protected
  BuildContext get context => screen.context;

  @override
  @protected
  Widget? builder() => null;

  /// The watch widget builder.
  ///
  /// If its null than mobile implementation is used,
  /// if that also null than tablet implementation is used,
  /// it that also null than desktop implementation is used.
  ///
  /// Other way builder implementation is used.
  @protected
  Widget? watch() => null;

  /// The mobile widget builder.
  ///
  /// If its null than tablet implementation is used,
  /// if that also null than desktop implementation is used.
  ///
  /// Other way builder implementation is used.
  @protected
  Widget? mobile() => null;

  /// The tablet widget builder.
  ///
  /// If its null than desktop implementation is used.
  ///
  /// Other way builder implementation is used.
  @protected
  Widget? tablet() => null;

  /// The desktop widget builder.
  ///
  /// If its null than builder implementation is used.
  @protected
  Widget? desktop() => null;

  /// Weather the screen has one implementation.
  bool get _hasImplementation =>
      watch() != null ||
      mobile() != null ||
      tablet() != null ||
      desktop() != null ||
      builder() != null;

  @override
  @protected
  @mustCallSuper
  Widget build(final BuildContext context) {
    screen._context = context;
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
    if (screen.isMobile) {
      widget = mobile() ?? tablet() ?? desktop();
      if (widget != null) return widget;
    }
    assert(_hasImplementation, 'Provide at least one implementation');
    return watch() ?? mobile() ?? tablet() ?? desktop() ?? builder()!;
  }
}
