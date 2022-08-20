//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart' show StateMixin;
import 'package:crow/src/view_model/state_view_model.dart';
import 'package:flutter/widgets.dart' show State, StatefulWidget;

/// [ViewState] is the implementation of [State].
///
/// Need tow type parameter the first is subclass of [StatefulWidget]
/// and the second is a subclass of [StateViewModel].
abstract class ViewState<T extends StatefulWidget, V extends StateViewModel>
    extends State<T> with StateMixin<T, V> {}
