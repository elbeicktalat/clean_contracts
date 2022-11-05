//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/contracts/domain/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends Service {
  SharedPreferences get preferences => _preferences;
  late SharedPreferences _preferences;

  Future<PreferencesService> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }
}
