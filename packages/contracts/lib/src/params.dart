//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_contracts/src/entity.dart';

class Params<E extends Entity> {
  Params({
    this.entity,
    this.page,
    this.records,
  });

  E? entity;
  int? page;
  int? records;
}
