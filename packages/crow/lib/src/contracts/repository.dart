//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/src/services/connectivity_service.dart';
import 'package:get/get.dart';

abstract class Repository {
  bool get isConnected => Get.find<ConnectivityService>().isConnected;
}
