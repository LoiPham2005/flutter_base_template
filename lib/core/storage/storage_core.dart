// lib/core/storage/_storage_core.dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageCore {
  final SharedPreferences _prefs;

  StorageCore(this._prefs);

  // === Generic Methods ===
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
}
