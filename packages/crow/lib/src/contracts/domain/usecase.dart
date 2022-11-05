//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/contracts/params.dart';

abstract class UseCase<T, P extends Params?> {
  Future<T> call(P params);
}
