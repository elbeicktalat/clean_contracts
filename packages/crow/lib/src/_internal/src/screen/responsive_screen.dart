//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

part of internal;

/// ResponsiveScreen holds utils information about the screen.
class ResponsiveScreen<T extends BaseViewModel> {
  ///
  ResponsiveScreen(this._settings);

  /// {@macro crow.context}
  @protected
  BuildContext get context => _context;
  late BuildContext _context;

  final ScreenSettings _settings;

  /// Whether the current platform is a desktop.
  bool get isPlatformDesktop =>
      Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  /// The width shorthand got from the [MediaQuery]
  double get width => MediaQuery.of(_context).size.width;

  /// The height shorthand got from the [MediaQuery]
  double get height => MediaQuery.of(_context).size.height;

  /// Weather the [_screenType] is [ScreenType.Watch]
  bool get isWatch => _screenType == ScreenType.watch;

  /// Weather the [_screenType] is [ScreenType.mobile]
  bool get isMobile => _screenType == ScreenType.mobile;

  /// Weather the [_screenType] is [ScreenType.Tablet]
  bool get isTablet => _screenType == ScreenType.tablet;

  /// Weather the [_screenType] is [ScreenType.Desktop]
  bool get isDesktop => _screenType == ScreenType.desktop;

  ScreenType get _screenType {
    final double deviceWidth = width;
    if (deviceWidth >= _settings.desktopChangePoint) return ScreenType.desktop;
    if (deviceWidth >= _settings.tabletChangePoint) return ScreenType.tablet;
    if (deviceWidth < _settings.watchChangePoint) return ScreenType.watch;
    return ScreenType.mobile;
  }

  /// Return widget according to screen type.
  ///
  /// if the [_screenType] is [ScreenType.desktop] and
  /// `desktop` object is null, than the `tablet` object will be returned
  /// and if `tablet` object is null, then the `mobile` object will be returned
  /// and if `mobile` object is null, than the `watch` object will be returned
  /// also when it is null.
  T? responsiveValue({
    final T? watch,
    final T? mobile,
    final T? tablet,
    final T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    if (isMobile && mobile != null) return mobile;
    return watch;
  }
}
