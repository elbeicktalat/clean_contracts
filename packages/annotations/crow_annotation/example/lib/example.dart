//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_annotation/crow_annotation.dart';

part 'example.g.dart';

@Equals()
@HashCode()
@ToString()
@Converter(User)
class UserModel {
  UserModel(
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.country,
    this.city,
    this.postalCode,
  );

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String postalCode;

  factory UserModel.fromUser(User user) => _$UserModelFromUser(user);

  User toUser() => _$UserModelToUser(this);

  @override
  String toString() => $toString();

  @override
  bool operator ==(Object other) => $equals(other);

  @override
  int get hashCode => $hashCode();
}

class User {
  User(
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.country,
    this.city,
    this.postalCode,
  );

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String postalCode;
}
