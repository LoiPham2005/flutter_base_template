// lib/core/storage/secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SecureStorage {
  // Constructor nhận FlutterSecureStorage từ DI
  SecureStorage(this._storage);
  final FlutterSecureStorage _storage;

  // Write
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Delete
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Delete all
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  // Check if key exists
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  // Read all
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  // === COMMON SECURE KEYS ===
  static const String keyAccessToken = 'secure_access_token';
  static const String keyRefreshToken = 'secure_refresh_token';
  static const String keyPassword = 'secure_password';
  static const String keyBiometric = 'secure_biometric';

  // Token methods
  Future<void> saveToken(String token) => write(keyAccessToken, token);
  Future<String?> getToken() => read(keyAccessToken);
  Future<void> clearToken() => delete(keyAccessToken);

  Future<void> saveRefreshToken(String token) => write(keyRefreshToken, token);
  Future<String?> getRefreshToken() => read(keyRefreshToken);
  Future<void> clearRefreshToken() => delete(keyRefreshToken);
}
