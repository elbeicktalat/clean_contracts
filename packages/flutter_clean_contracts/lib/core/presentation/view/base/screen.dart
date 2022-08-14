import 'package:clean_contracts/core/presentation/view/base/view.dart';
import 'package:clean_contracts/core/presentation/view/utils/screen_settings.dart';
import 'package:clean_contracts/core/presentation/view_model/view_model.dart';
import 'package:flutter/widgets.dart' show Widget, protected;

/// The base mixin for every Screen.
mixin BaseScreenMixin<T extends BaseViewModel> on BaseViewMixin<T> {
  /// Get util info about the screen.
  ResponsiveScreen<T> get screen;

  /// Force the usage of the [builder] methods.
  ///
  /// Override this to ignore other [builder]s.
  bool get alwaysUseBuilder => false;

  @override
  Widget? builder() => null;

  /// The watch widget builder.
  ///
  /// If its null than mobile implementation is used,
  /// if that also null than tablet implementation is used,
  /// it that also null than desktop implementation is used.
  ///
  /// Other way builder implementation is used.
  Widget? watch() => null;

  /// The mobile widget builder.
  ///
  /// If its null than tablet implementation is used,
  /// if that also null than desktop implementation is used.
  ///
  /// Other way builder implementation is used.
  Widget? mobile() => null;

  /// The tablet widget builder.
  ///
  /// If its null than desktop implementation is used.
  ///
  /// Other way builder implementation is used.
  Widget? tablet() => null;

  /// The desktop widget builder.
  ///
  /// If its null than builder implementation is used.
  Widget? desktop() => null;

  /// Weather the screen has one implementation.
  @protected
  bool get hasImplementation =>
      watch() != null ||
      mobile() != null ||
      tablet() != null ||
      desktop() != null ||
      builder() != null;
}
