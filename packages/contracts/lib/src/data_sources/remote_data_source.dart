//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_contracts/src/data_sources/data_source.dart';
import 'package:crow_contracts/src/entity.dart';
import 'package:crow_contracts/src/params.dart';
import 'package:meta/meta.dart';

abstract class BaseRemoteDataSource<T, ID extends Object, E extends Entity,
    P extends Params<E>> extends DataSource<T, E, P> {}

abstract class RemoteDataSource<T, ID extends Object, E extends Entity,
    P extends Params<E>> extends BaseRemoteDataSource<T, ID, E, P> {
  Future<T> save(E entity);

  Future<E?> find(ID id);

  Future<List<E>?> findAll({P? params});

  Future<T> update();

  Future<T> delete(ID id);
}

@optionalTypeArgs
abstract class EmptyRemoteDataSource<T, ID extends Object, E extends Entity,
    P extends Params<E>> extends BaseRemoteDataSource<T, ID, E, P> {}
