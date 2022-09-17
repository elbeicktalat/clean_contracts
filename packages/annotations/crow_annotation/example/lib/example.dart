//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow_annotation/crow_annotation.dart';
import 'package:meta/meta.dart';

part 'example.g.dart';

@Super()
@Equals()
@HashCode()
@ToString()
@Immutable()
@Converter(User)
class UserModel extends _UserModel {
  UserModel(
    String super.firstName,
    String super.lastName,
    String super.email,
    String super.phone,
    DateTime super.dateOfBirth,
    String super.country,
    String super.city,
    String super.postalCode,
  );
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
