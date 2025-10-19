import 'dart:convert';
import 'package:flutter_base_template/core/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class StorageService {
  StorageService(this._prefs);
  final SharedPreferences _prefs;

  // === Generic Methods ===
  T? _get<T>(String key) {
    return _prefs.get(key) as T?;
  }

  Future<bool> _set<T>(String key, T value) {
    if (value is String) return _prefs.setString(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    if (value is List<String>) return _prefs.setStringList(key, value);
    return Future.value(false);
  }

  Future<bool> remove(String key) => _prefs.remove(key);
  Future<bool> clearAll() => _prefs.clear();

  // === Specific Business Logic ===

  // --- Auth ---
  Future<bool> saveToken(String token) => _set(StorageKeys.accessToken, token);
  String? getToken() => _get<String>(StorageKeys.accessToken);

  Future<bool> saveRefreshToken(String token) =>
      _set(StorageKeys.refreshToken, token);
  String? getRefreshToken() => _get<String>(StorageKeys.refreshToken);

  Future<bool> saveUser(Map<String, dynamic> user) {
    return _set(StorageKeys.userProfile, json.encode(user));
  }

  Map<String, dynamic>? getUser() {
    final userString = _get<String>(StorageKeys.userProfile);
    if (userString == null) return null;
    return json.decode(userString) as Map<String, dynamic>;
  }

  Future<bool> setLoggedIn(bool value) => _set(StorageKeys.isLogin, value);
  bool isLoggedIn() => _get<bool>(StorageKeys.isLogin) ?? false;

  Future<void> clearAuthData() async {
    await remove(StorageKeys.accessToken);
    await remove(StorageKeys.refreshToken);
    await remove(StorageKeys.userProfile);
    await remove(StorageKeys.isLogin);
  }

  // --- App Settings ---
  Future<bool> setFirstRun(bool value) => _set(StorageKeys.isFirstRun, value);
  bool isFirstRun() => _get<bool>(StorageKeys.isFirstRun) ?? true;

  Future<bool> saveThemeMode(String mode) => _set(StorageKeys.themeMode, mode);
  String? getThemeMode() => _get<String>(StorageKeys.themeMode);
}
