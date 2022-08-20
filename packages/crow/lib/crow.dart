//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

/// Crow gives you util widgets interfaces to apply separation of concerns.
///
/// To use, import `package:crow/crow.dart`.
///
/// See also:
///
/// * [Examples](https://github.com/elbeicktalat/crow)
library crow;

import 'package:crow/src/view_model/view_model.dart';
import 'package:get_it/get_it.dart';

export 'package:crow/src/stateful/screen.dart';
export 'package:crow/src/stateful/view.dart';
export 'package:crow/src/stateless/screen.dart';
export 'package:crow/src/stateless/view.dart';
export 'package:crow/src/utils/screen_settings.dart';
export 'package:crow/src/utils/screen_type.dart';
export 'package:crow/src/view_model/state_view_model.dart';
export 'package:crow/src/view_model/view_model.dart';

/// The glue between the crow widgets and your app.
class Crow {
  const Crow._internal();

  /// The current [Crow], if one has been created.
  static Crow get instance => _instance;
  static const Crow _instance = Crow._internal();

  /// The place in where preregistered dependencies get registered.
  void initDependencies() {
    GetIt.instance
      ..registerLazySingleton<ViewModel>(DefaultViewModel.new)
      ..registerLazySingleton<DefaultViewModel>(DefaultViewModel.new);
  }
}
