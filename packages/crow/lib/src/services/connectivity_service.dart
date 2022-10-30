//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crow/src/contracts/domain/service.dart';

class ConnectivityService extends Service {
  late Connectivity _connectivity;

  bool get isConnected => _isConnected;
  late bool _isConnected;

  void _checkConnectivity() async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    _isConnected = resolve(connectivityResult);
  }

  @override
  void onInit() {
    super.onInit();
    _connectivity = Connectivity();
    _checkConnectivity();
  }

  static bool resolve(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.vpn:
      case ConnectivityResult.none:
        return false;
    }
  }
}
