//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_contracts/src/data_sources/data_source.dart';
import 'package:crow_contracts/src/entity.dart';
import 'package:crow_contracts/src/params.dart';
import 'package:meta/meta.dart';

abstract class _BaseRepository<T, ID extends Object, E extends Entity,
    P extends Params<E>> {}

/// Repository is the middleman between the [DataSource] and ViewModel,
/// its offer some methods to be implemented for the uniforming code style.
///
/// Repository dose accept the following type parameters:
///
/// * [T] - A generic type, this defines the return type signature
/// for the non [Entity] returns. e.g: the methods [save], [update], [delete]
/// they return a [Future] of [T] which can be a void, bool ect.
///
/// * [ID] - A subtype of [Object], this defines the data type of the id.
/// e.g: the id can be a [String] or [int] ect.
///
/// * [E] - A subtype of [Entity], this defines the entity
/// maneged by this repository.
///
/// * [P] - A subtype of [Params], this is helpful to supply methods
/// with custom parameters.
abstract class Repository<T, ID extends Object, E extends Entity,
    P extends Params<E>> extends _BaseRepository<T, ID, E, P> {
  /// Saves a single record to [DataSource].
  Future<T> save(E entity);

  /// Finds a single record from [DataSource].
  Future<E?> find(ID id);

  /// Finds all records from [DataSource].
  Future<List<E>?> findAll({P? params});

  /// Updates a single record by the given [id] with the new [entity] object.
  Future<T> update(ID id, E entity);

  /// Deletes a single record of the given [id].
  Future<T> delete(ID id);
}

/// The empty [Repository], this allows you to define your custom methods.
@optionalTypeArgs
abstract class EmptyRepository<T, ID extends Object, E extends Entity,
    P extends Params<E>> extends _BaseRepository<T, ID, E, P> {}
