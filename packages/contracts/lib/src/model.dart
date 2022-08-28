//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_contracts/src/entity.dart';

abstract class Model<E extends Entity> {
  E toEntity();

  Map<String, dynamic> toJson();
}
