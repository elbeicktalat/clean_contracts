import 'package:flutter/widgets.dart' show BuildContext, WidgetBuilder;

/// The parent of all ViewModels.
abstract class BaseViewModel {
  /// The [context] contains information about the location in the
  /// tree at which the associated widget is being built.
  ///
  /// This [context] get defined within [WidgetBuilder] method.
  late BuildContext context;
}
