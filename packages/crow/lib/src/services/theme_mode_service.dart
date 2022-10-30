//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

import 'package:crow/crow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeService extends Service {
  final Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.system);
  late Rx<Brightness?> _brightness;

  SharedPreferences get _preferences => Get.find<PreferencesService>().instance;

  bool get isSystemMode {
    final String? source = _preferences.getString(_themeModeKey);
    if (source == null) return themeMode == ThemeMode.system;
    return parse(source) == ThemeMode.system;
  }

  bool get isDarkMode {
    return _brightness.value == Brightness.dark || themeMode == ThemeMode.dark;
  }

  static const String _themeModeKey = 'application_theme_mode';

  @override
  void onInit() {
    super.onInit();
    _brightness = SchedulerBinding.instance.window.platformBrightness.obs;
    final String? source = _preferences.getString(_themeModeKey);
    if (source != null) {
      themeMode.value = parse(source);
    }
    print(isDarkMode);
  }

  /// Sets a new value to the [themeMode].
  void setThemeMode(ThemeMode value) {
    if (themeMode.value == value) return;
    themeMode.value = value;
    _preferences.setString(_themeModeKey, value.name);
  }

  /// Switch between dark and light mode.
  void changeThemeMode() {
    if (isDarkMode) {
      setThemeMode(ThemeMode.light);
      _brightness.value = Brightness.light;
    } else {
      setThemeMode(ThemeMode.dark);
      _brightness.value = Brightness.dark;
    }
  }

  /// Reset to use the system mode.
  void reset() {
    setThemeMode(ThemeMode.system);
  }

  static ThemeMode parse(String source) {
    assert(
      source == ThemeMode.system.name ||
          source == ThemeMode.light.name ||
          source == ThemeMode.dark.name,
      'The source must be one of the following values:'
      ' ${ThemeMode.values.map((ThemeMode e) => e.name)}',
    );
    late ThemeMode result;
    switch (source) {
      case 'system':
        result = ThemeMode.system;
        break;
      case 'light':
        result = ThemeMode.light;
        break;
      case 'dark':
        result = ThemeMode.dark;
        break;
    }

    return result;
  }
}
