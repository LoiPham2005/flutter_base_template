// lib/core/storage/local_storage.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static LocalStorage? _instance;
  static SharedPreferences? _preferences;
  
  LocalStorage._();
  
  static Future<LocalStorage> getInstance() async {
    _instance ??= LocalStorage._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }
  
  factory LocalStorage() {
    if (_instance == null || _preferences == null) {
      throw Exception('LocalStorage chưa được khởi tạo. Gọi getInstance() trước.');
    }
    return _instance!;
  }
  
  // String
  Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }
  
  String? getString(String key) {
    return _preferences!.getString(key);
  }
  
  // Int
  Future<bool> setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }
  
  int? getInt(String key) {
    return _preferences!.getInt(key);
  }
  
  // Double
  Future<bool> setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }
  
  double? getDouble(String key) {
    return _preferences!.getDouble(key);
  }
  
  // Bool
  Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }
  
  bool? getBool(String key) {
    return _preferences!.getBool(key);
  }
  
  // List<String>
  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }
  
  List<String>? getStringList(String key) {
    return _preferences!.getStringList(key);
  }
  
  // JSON Object
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return await setString(key, json.encode(value));
  }
  
  Map<String, dynamic>? getObject(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;
    return json.decode(jsonString) as Map<String, dynamic>;
  }
  
  // Remove
  Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }
  
  // Clear all
  Future<bool> clear() async {
    return await _preferences!.clear();
  }
  
  // Check if key exists
  bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }
  
  // Get all keys
  Set<String> getKeys() {
    return _preferences!.getKeys();
  }
  
  // === COMMON STORAGE KEYS ===
  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUser = 'user';
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';
  static const String keyFirstLaunch = 'first_launch';
  
  // Auth
  Future<bool> saveToken(String token) => setString(keyToken, token);
  String? getToken() => getString(keyToken);
  Future<bool> clearToken() => remove(keyToken);
  
  Future<bool> saveRefreshToken(String token) => setString(keyRefreshToken, token);
  String? getRefreshToken() => getString(keyRefreshToken);
  
  Future<bool> saveUser(Map<String, dynamic> user) => setObject(keyUser, user);
  Map<String, dynamic>? getUser() => getObject(keyUser);
  Future<bool> clearUser() => remove(keyUser);
  
  // Settings
  Future<bool> saveLanguage(String language) => setString(keyLanguage, language);
  String? getLanguage() => getString(keyLanguage);
  
  Future<bool> saveThemeMode(String mode) => setString(keyThemeMode, mode);
  String? getThemeMode() => getString(keyThemeMode);
  
  Future<bool> setFirstLaunch(bool value) => setBool(keyFirstLaunch, value);
  bool isFirstLaunch() => getBool(keyFirstLaunch) ?? true;
}
