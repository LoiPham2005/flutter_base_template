// lib/core/storage/cache_manager.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheManager {
  
  CacheManager._(this._prefs);
  
  static CacheManager? _instance;
  final SharedPreferences _prefs;
  
  static Future<CacheManager> getInstance() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = CacheManager._(prefs);
    }
    return _instance!;
  }
  
  // Save cache with expiration
  Future<bool> saveCache<T>(
    String key,
    T data, {
    Duration? expiration,
  }) async {
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiration': expiration?.inMilliseconds,
    };
    
    return await _prefs.setString(key, json.encode(cacheData));
  }
  
  // Get cache
  T? getCache<T>(String key) {
    final cacheString = _prefs.getString(key);
    if (cacheString == null) return null;
    
    try {
      final cacheData = json.decode(cacheString) as Map<String, dynamic>;
      
      // Check expiration
      if (cacheData['expiration'] != null) {
        final timestamp = cacheData['timestamp'] as int;
        final expiration = cacheData['expiration'] as int;
        final now = DateTime.now().millisecondsSinceEpoch;
        
        if (now - timestamp > expiration) {
          // Cache expired
          removeCache(key);
          return null;
        }
      }
      
      return cacheData['data'] as T;
    } catch (e) {
      return null;
    }
  }
  
  // Remove cache
  Future<bool> removeCache(String key) async {
    return await _prefs.remove(key);
  }
  
  // Clear all cache
  Future<bool> clearAllCache() async {
    final keys = _prefs.getKeys().where((key) => key.startsWith('cache_'));
    for (final key in keys) {
      await _prefs.remove(key);
    }
    return true;
  }
  
  // Check if cache exists and valid
  bool isCacheValid(String key) {
    final cacheString = _prefs.getString(key);
    if (cacheString == null) return false;
    
    try {
      final cacheData = json.decode(cacheString) as Map<String, dynamic>;
      
      if (cacheData['expiration'] != null) {
        final timestamp = cacheData['timestamp'] as int;
        final expiration = cacheData['expiration'] as int;
        final now = DateTime.now().millisecondsSinceEpoch;
        
        return now - timestamp <= expiration;
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }
}