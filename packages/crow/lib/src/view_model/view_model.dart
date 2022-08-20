//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/crow.dart';
import 'package:crow/src/_internal/internal.dart' show BaseViewModel;

/// The ViewModel to associate with StatelessWidget.
///
/// If the [View] or the [Screen] type parameter is not specified,
/// than this [ViewModel] becomes the default one.
abstract class ViewModel extends BaseViewModel {}
