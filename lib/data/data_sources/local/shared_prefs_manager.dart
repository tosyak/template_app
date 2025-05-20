import 'package:flutter/material.dart';
import 'package:ricknotmorty/core/data_base/app_preferences.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A utility class containing constant keys used for storing and retrieving preferences
/// in the application's shared preferences storage.
class PreferenceKeys {
  static const String locale = 'locale';
  static const String themeMode = 'themeMode';
}

/// Manages application preferences using SharedPreferences, implementing the AppPreferences interface
///
/// This class provides methods for storing and retrieving various application settings
/// such as locale and theme mode, with error handling and logging capabilities.
class SharedPrefsManager with AppLogger implements AppPreferences {
  final SharedPreferences _preferences;

  SharedPrefsManager(this._preferences);

  String _getString(String key, {String defaultValue = ''}) {
    try {
      return _preferences.getString(key) ?? defaultValue;
    } catch (e) {
      log.severe('[$runtimeType] Failed to get string value for key $key: $e');
      return defaultValue;
    }
  }

  Future<void> _setString(String key, String value) async {
    try {
      await _preferences.setString(key, value);
    } catch (e) {
      log.severe('[$runtimeType] Failed to set string value for key $key: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveLocale(String val) {
    log.severe('Saved locale with code $val');
    return _setString(PreferenceKeys.locale, val);
  }

  @override
  Future<String?> get locale async {
    final val = _getString(PreferenceKeys.locale, defaultValue: '');
    return val.isEmpty ? null : val;
  }

  @override
  Future<void> saveLanguageByCode(String key, String val) =>
      _setString(key, val);

  @override
  Future<String> getLanguageByCode(String langCode) async =>
      _getString(langCode, defaultValue: '');

  @override
  Future<ThemeMode> get themeMode async {
    final val = _getString(PreferenceKeys.themeMode, defaultValue: '');
    if (val.isEmpty) return ThemeMode.system;

    try {
      return ThemeMode.values.firstWhere((e) => e.toString() == val);
    } catch (e) {
      log.severe(
        '[$runtimeType] Invalid theme mode value: $val. Falling back to system mode.',
      );
      return ThemeMode.system;
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode val) =>
      _setString(PreferenceKeys.themeMode, val.toString());
}
