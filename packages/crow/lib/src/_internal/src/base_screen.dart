//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

part of internal;

/// The base mixin for the public [Screen].
///
/// This mixin need a type parameter of [BaseViewModel].
@internal
mixin BaseScreenMixin<T extends BaseViewModel>
    on GetResponsiveView<T>, BaseViewMixin<T> {
  @override
  BuildContext get context => screen.context;
}
