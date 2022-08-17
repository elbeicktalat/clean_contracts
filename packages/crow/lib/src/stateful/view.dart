//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/base/view.dart';
import 'package:crow/src/view_model/state_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The State mixin.
///
/// This allows the [StateViewModel] to deal with [State] methods.
mixin StateMixin<T extends StatefulWidget, V extends StateViewModel>
    on BaseViewMixin<V>, State<T> {
  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    viewModel.initState();
  }

  @protected
  @override
  @mustCallSuper
  void reassemble() {
    viewModel.reassemble();
    super.reassemble();
  }

  @protected
  @override
  @mustCallSuper
  void deactivate() {
    viewModel.deactivate();
    super.deactivate();
  }

  @protected
  @override
  @mustCallSuper
  void activate() {
    super.activate();
    viewModel.activate();
  }

  @protected
  @override
  @mustCallSuper
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @protected
  @override
  @mustCallSuper
  void didChangeDependencies() {
    viewModel.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<V>('viewModel', viewModel));
    viewModel.debugFillProperties(properties);
  }
}

/// [ViewState] is the implementation of [State].
///
/// Need tow type parameter the first is subclass of [StatefulWidget]
/// and the second is a subclass of [StateViewModel].
abstract class ViewState<T extends StatefulWidget, V extends StateViewModel>
    extends State<T> with BaseViewMixin<V>, StateMixin<T, V> {}
