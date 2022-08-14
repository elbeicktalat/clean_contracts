import 'package:flutter/material.dart';

/// The parent of all ViewModels.
abstract class BaseViewModel {
  /// The [context] contains information about the location in the
  /// tree at which the associated widget is being built.
  ///
  /// This [context] get defined within [WidgetBuilder] method.
  late BuildContext context;
}

/// The ViewModel to associate with StatelessWidget.
abstract class ViewModel extends BaseViewModel {}

/// The preregistered [ViewModel].
///
/// Use this if you haven't any custom stuffs.
class BasicViewModel extends ViewModel {}
