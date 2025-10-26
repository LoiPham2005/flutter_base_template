// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/json_utils.dart
// ════════════════════════════════════════════════════════════════
import 'dart:convert';

class JsonUtils {
  JsonUtils._();

  /// Safely parse JSON string
  static Map<String, dynamic>? parseObject(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Safely parse JSON array
  static List<dynamic>? parseArray(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      return json.decode(jsonString) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Safely encode object to JSON
  static String? encode(dynamic object) {
    try {
      return json.encode(object);
    } catch (e) {
      return null;
    }
  }

  /// Pretty print JSON
  static String prettyPrint(dynamic object) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(object);
    } catch (e) {
      return object.toString();
    }
  }

  /// Safely get value from JSON
  static T? getValue<T>(Map<String, dynamic>? json, String key, {T? defaultValue}) {
    if (json == null || !json.containsKey(key)) return defaultValue;
    try {
      return json[key] as T;
    } catch (e) {
      return defaultValue;
    }
  }
}