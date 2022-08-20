//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/_internal/internal.dart' show BaseViewModel;

/// The ViewModel to associate with StatelessWidget.
abstract class ViewModel extends BaseViewModel {}

/// The preregistered [ViewModel].
///
/// Use this if you haven't any custom stuffs.
class BasicViewModel extends ViewModel {}
