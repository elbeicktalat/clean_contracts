//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crow/src/contracts/domain/service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' show Rx, RxT;

class ConnectivityService extends Service {
  Connectivity get connectivity => _connectivity;
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  /// A void callback called everytime the connectivity is changes.
  ///
  /// You can make use of this property as you like,
  /// for example: show a snack bar to inform the user about the connectivity status.
  VoidCallback? onConnectivityChange;

  /// Whether the device is connected the the internet.
  ///
  /// This is make sure that you have a real access to the internet.
  bool get isConnected => _isConnected.value;
  late Rx<bool> _isConnected;

  Future<void> _checkConnectivity() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    _isConnected = resolve(result).obs;
    _checkInternetConnectionStatus(result);
  }

  void _checkInternetConnectionStatus(ConnectivityResult result) async {
    late bool isOnline;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (exception, stackTrace) {
      isOnline = false;
      debugPrint(exception.toString());
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _isConnected.value = isOnline && resolve(result);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected.value = resolve(result);
      _checkInternetConnectionStatus(result);
      onConnectivityChange?.call();
    });
  }

  Future<ConnectivityService> init() async {
    await _checkConnectivity();
    return this;
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
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
      case ConnectivityResult.other:
        return false;
    }
  }
}
