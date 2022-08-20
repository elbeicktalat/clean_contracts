//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

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
