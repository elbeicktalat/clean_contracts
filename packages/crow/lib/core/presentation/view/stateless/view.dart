import 'package:crow/core/presentation/view/base/view.dart';
import 'package:crow/core/presentation/view_model/view_model.dart';
import 'package:flutter/material.dart';

/// The StatelessWidget mixin.
mixin ViewMixin<T extends ViewModel> on StatelessWidget, BaseViewMixin<T> {
  @override
  Widget build(final BuildContext context) {
    viewModel.context = context;
    Widget? widget;
    widget = builder();
    if (widget != null) return widget;
    return builder()!;
  }
}

/// The [StatelessWidget] which comes with viewModel instance
/// and some other utilities.
///
/// You must define the type parameter in order to get the expected ViewModel.
abstract class View<T extends ViewModel> extends StatelessWidget
    with BaseViewMixin<T>, ViewMixin<T> {
  ///
  const View({final super.key});
}
