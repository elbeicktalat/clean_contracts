//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/crow.dart';
import 'package:crow_annotation/crow_annotation.dart';

@Autowired.async(permanent: true)
class UserService extends AsyncService<UserService> {
  @override
  Future<UserService> async() async {
    return this;
  }
}
