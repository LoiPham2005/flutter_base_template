// lib/core/storage/storage_service.dart
import 'dart:convert';
import 'package:flutter_base_template/core/storage/storage_core.dart';
import 'package:flutter_base_template/core/storage/storage_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class StorageService {
  final StorageCore _core;

  StorageService(SharedPreferences prefs) : _core = StorageCore(prefs);

  // === Auth ===
  Future<bool> saveToken(String token) => _core.set(StorageKeys.accessToken, token);
  String? getToken() => _core.get<String>(StorageKeys.accessToken);

  Future<bool> saveRefreshToken(String token) =>
      _core.set(StorageKeys.refreshToken, token);
  String? getRefreshToken() => _core.get<String>(StorageKeys.refreshToken);

  Future<bool> saveUser(Map<String, dynamic> user) {
    return _core.set(StorageKeys.userProfile, json.encode(user));
  }

  Map<String, dynamic>? getUser() {
    final userString = _core.get<String>(StorageKeys.userProfile);
    if (userString == null) return null;
    return json.decode(userString) as Map<String, dynamic>;
  }

  Future<bool> setLoggedIn(bool value) => _core.set(StorageKeys.isLogin, value);
  bool isLoggedIn() => _core.get<bool>(StorageKeys.isLogin) ?? false;

  Future<void> clearAuthData() async {
    await _core.remove(StorageKeys.accessToken);
    await _core.remove(StorageKeys.refreshToken);
    await _core.remove(StorageKeys.userProfile);
    await _core.remove(StorageKeys.isLogin);
  }

  // === App Settings ===
  Future<bool> setFirstRun(bool value) => _core.set(StorageKeys.isFirstRun, value);
  bool isFirstRun() => _core.get<bool>(StorageKeys.isFirstRun) ?? true;

  Future<bool> saveThemeMode(String mode) => _core.set(StorageKeys.themeMode, mode);
  String? getThemeMode() => _core.get<String>(StorageKeys.themeMode);
}
