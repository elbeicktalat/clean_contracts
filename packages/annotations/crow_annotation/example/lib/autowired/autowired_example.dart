//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_annotation/crow_annotation.dart';
import 'package:example/autowired/autowired_example.binding.dart';
import 'package:example/autowired/user_repository/user_repository.dart';
import 'package:example/autowired/user_service/user_service.dart';

@Autowired()
class UserViewModel {
  UserViewModel(this._userRepository, this._userService);

  @Autowired(tag: '_userRepositoryTag')
  final UserRepository _userRepository;

  final UserService _userService;
}

void main() {
  UserViewModelBinding();
}
