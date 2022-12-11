//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_annotation/crow_annotation.dart';
import 'package:example/autowired/user_remote_data_source/user_remote_data_source.dart';

@Autowired.put(as: UserRepository, tag: '_userRepositoryTag')
class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;
}

abstract class UserRepository {}
