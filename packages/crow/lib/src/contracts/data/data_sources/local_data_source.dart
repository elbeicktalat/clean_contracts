//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/contracts/data/data_sources/data_source.dart';
import 'package:crow/src/services/preferences_service.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource extends DataSource {
  @protected
  SharedPreferences get preferences => Get.find<PreferencesService>().instance;
}
