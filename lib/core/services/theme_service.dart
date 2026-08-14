import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeService {
  static const String _boxName = 'settings_box';
  static const String _key = 'isDarkMode';

  Box get _box => Hive.box(_boxName);

  /// Ensure box is open (called on app startup if needed)
  static Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
  }

  /// Load theme mode from Hive storage
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() {
    if (!Hive.isBoxOpen(_boxName)) return false;
    return _box.get(_key, defaultValue: false);
  }

  /// Save theme mode setting
  void _saveThemeToBox(bool isDarkMode) {
    if (Hive.isBoxOpen(_boxName)) {
      _box.put(_key, isDarkMode);
    }
  }

  /// Get current theme boolean state
  bool isDarkMode() => _loadThemeFromBox();

  /// Switch theme dynamically
  void switchTheme() {
    final newMode = !_loadThemeFromBox();
    Get.changeThemeMode(newMode ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(newMode);
  }
}
