//  Copyright (c) 2020-2022 All rights reserved.

//  Crow and Crow annotation are developed by Talat El Beick.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

//  GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutowiredGenerator
// **************************************************************************

import 'package:crow/crow.dart';
import 'package:example/autowired/user_remote_data_source/user_remote_data_source.dart';
import 'package:example/autowired/user_repository/user_repository.dart';

class UserRepositoryBinding extends Binding {
  void dependencies() {
    put<UserRepository>(
      UserRepositoryImpl(
        find<UserRemoteDataSource>(),
      ),
      tag: '_userRepositoryTag',
    );
  }
}
