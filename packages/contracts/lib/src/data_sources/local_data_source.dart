//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_contracts/src/data_sources/data_source.dart';
import 'package:crow_contracts/src/entity.dart';
import 'package:crow_contracts/src/params.dart';
import 'package:meta/meta.dart';

abstract class BaseLocalDataSource<T, E extends Entity, P extends Params<E>>
    extends DataSource<T, E, P> {}

abstract class LocalDataSource<T, E extends Entity, P extends Params<E>>
    extends BaseLocalDataSource<T, E, P> {
  Future<T> saveAll(List<E> entities);

  Future<List<E?>> findAll(P? params);

  Future<T> deleteAll();
}

@optionalTypeArgs
abstract class EmptyLocalDataSource<T, E extends Entity, P extends Params<E>>
    extends BaseLocalDataSource<T, E, P> {}
