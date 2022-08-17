import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/widgets.dart' show Widget, protected;
import 'package:get_it/get_it.dart' show GetIt;

/// The base mixin for every View.
///
/// This mixin need a type parameter of [BaseViewModel].
mixin BaseViewMixin<T extends BaseViewModel> on Widget {
  GetIt get _getIt => GetIt.instance;

  /// The instance of the ViewModel.
  @protected
  T get viewModel => _getIt.get<T>();

  /// The widget method which get the place of build method.
  @protected
  Widget? builder();
}
