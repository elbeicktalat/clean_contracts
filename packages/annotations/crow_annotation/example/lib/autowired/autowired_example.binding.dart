//  Copyright (c) 2020-2022 All rights reserved.

//  Crow and Crow annotation are developed by Talat El Beick.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

//  GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutowiredGenerator
// **************************************************************************

import 'package:crow/crow.dart';
import 'package:example/autowired/autowired_example.dart';
import 'package:example/autowired/user_repository/user_repository.dart';
import 'package:example/autowired/user_service/user_service.dart';

class UserViewModelBinding extends Binding {
  void dependencies() {
    lazyPut(
      () => UserViewModel(
        find<UserRepository>(tag: '_userRepositoryTag'),
        find<UserService>(),
      ),
    );
  }
}
