// lib/core/storage/storage_service.dart
import 'dart:convert';
import 'package:flutter_base_template/core/storage/storage_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// ============================
  /// GENERIC METHODS
  /// ============================
  T? get<T>(String key) {
    return _prefs.get(key) as T?;
  }

  Future<bool> set<T>(String key, T value) {
    if (value is String) return _prefs.setString(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    if (value is List<String>) return _prefs.setStringList(key, value);
    return Future.value(false);
  }

  Future<bool> remove(String key) => _prefs.remove(key);
  Future<bool> clearAll() => _prefs.clear();

  /// ============================
  /// AUTH METHODS
  /// ============================
  Future<bool> saveToken(String token) => set(StorageKeys.accessToken, token);
  String? getToken() => get<String>(StorageKeys.accessToken);

  Future<bool> saveRefreshToken(String token) =>
      set(StorageKeys.refreshToken, token);
  String? getRefreshToken() => get<String>(StorageKeys.refreshToken);

  Future<bool> saveUser(Map<String, dynamic> user) async {
    return set(StorageKeys.userProfile, json.encode(user));
  }

  Map<String, dynamic>? getUser() {
    final userString = get<String>(StorageKeys.userProfile);
    if (userString == null) return null;
    return json.decode(userString) as Map<String, dynamic>;
  }

  Future<bool> setLoggedIn(bool value) => set(StorageKeys.isLogin, value);
  bool isLoggedIn() => get<bool>(StorageKeys.isLogin) ?? false;

  Future<void> clearAuthData() async {
    await remove(StorageKeys.accessToken);
    await remove(StorageKeys.refreshToken);
    await remove(StorageKeys.userProfile);
    await remove(StorageKeys.isLogin);
  }

  /// ============================
  /// APP SETTINGS
  /// ============================
  Future<bool> setFirstRun(bool value) => set(StorageKeys.isFirstRun, value);
  bool isFirstRun() => get<bool>(StorageKeys.isFirstRun) ?? true;

  Future<bool> saveThemeMode(String mode) => set(StorageKeys.themeMode, mode);
  String? getThemeMode() => get<String>(StorageKeys.themeMode);
}
