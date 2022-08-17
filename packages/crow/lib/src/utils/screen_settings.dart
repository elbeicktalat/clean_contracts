//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'dart:io';

import 'package:crow/src/utils/screen_type.dart';
import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/material.dart';

const double _defaultDesktopChangePoint = 1200.0;
const double _defaultTabletChangePoint = 600.0;
const double _defaultWatchChangePoint = 300.0;

/// The ScreenSettings defines the Change points.
class ScreenSettings {
  ///
  const ScreenSettings({
    this.desktopChangePoint = _defaultDesktopChangePoint,
    this.tabletChangePoint = _defaultTabletChangePoint,
    this.watchChangePoint = _defaultWatchChangePoint,
  });

  /// When the width is greater than this value
  /// the display will be set as [ScreenType.desktop]
  final double desktopChangePoint;

  /// When the width is greater than this value
  /// the display will be set as [ScreenType.tablet]
  /// or when width greater than [watchChangePoint] and smaller than this value
  /// the display will be [ScreenType.mobile]
  final double tabletChangePoint;

  /// When the width is smaller than this value
  /// the display will be set as [ScreenType.watch]
  /// or when width greater than this value and smaller also [tabletChangePoint]
  /// the display will be [ScreenType.mobile]
  final double watchChangePoint;
}

/// ResponsiveScreen holds utils information about the screen.
class ResponsiveScreen<T extends BaseViewModel> {
  ///
  ResponsiveScreen(this._settings);

  /// The [context] contains information about the location in the
  /// tree at which the associated widget is being built.
  ///
  /// This [context] get defined within [WidgetBuilder] method.
  late BuildContext context;

  final ScreenSettings _settings;

  /// Whether the current platform is a desktop.
  bool get isPlatformDesktop =>
      Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  /// The width shorthand got from the [MediaQuery]
  double get width => MediaQuery.of(context).size.width;

  /// The height shorthand got from the [MediaQuery]
  double get height => MediaQuery.of(context).size.height;

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
