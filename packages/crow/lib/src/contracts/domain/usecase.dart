//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/contracts/domain/entity.dart';
import 'package:crow/src/contracts/params.dart';

abstract class UseCase<E extends Entity, P extends Params?> {
  Future<E?> call(P params);
}
