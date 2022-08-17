import 'package:flutter/widgets.dart';

/// The [BuildContext] extension which make life easier.
extension BuildContextextension on BuildContext {
  /// The horizontal extent of this size.
  double get width => MediaQuery.of(this).size.width;

  /// The vertical extent of this size.
  double get height => MediaQuery.of(this).size.height;

  /// The orientation of the media (e.g., whether the device is in landscape or
  /// portrait mode).
  Orientation get orientation => MediaQuery.of(this).orientation;
}
