//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_annotation/crow_annotation.dart';

part 'user_model.g.dart';

class UserEntity {
  const UserEntity(
    this.id, {
    this.name,
  });

  final int? id;
  final String? name;
}

@Convert(UserEntity)
class UserModel {
  UserModel(
    this.id, {
    this.name,
  });

  final int? id;
  final String? name;

  factory UserModel.fromEntity(UserEntity entity) =>
      _$UserModelFromUserEntity(entity);

  UserEntity toEntity() => _$UserModelToUserEntity(this);
}
