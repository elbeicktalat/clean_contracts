//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

part of internal;

/// The base mixin for every View.
///
/// This mixin need a type parameter of [BaseViewModel].
mixin BaseViewMixin<T extends BaseViewModel> {
  GetIt get _getIt => GetIt.instance;

  /// The instance of the ViewModel.
  @protected
  T get viewModel => _getIt.get<T>();

  /// The widget method which get the place of build method.
  @protected
  Widget? builder();

  /// Flutter build method, don't override this method instate use builder.
  @protected
  Widget build(final BuildContext context) {
    viewModel._context = context;
    return builder()!;
  }
}
