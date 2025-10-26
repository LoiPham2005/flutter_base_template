// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/device_utils.dart
// ════════════════════════════════════════════════════════════════
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  DeviceUtils._();

  static final _deviceInfo = DeviceInfoPlugin();

  /// Check platform
  static bool get isIOS => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;
  static bool get isWeb => false; // Set to true if supporting web
  static Map<String, dynamic>? _cachedDeviceInfo;
  static Map<String, String>? _cachedAppInfo;

  /// Get device info
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    if (_cachedDeviceInfo != null) return _cachedDeviceInfo!;

    final Map<String, dynamic> deviceInfo = {};

    if (isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      deviceInfo.addAll({
        'platform': 'Android',
        'model': androidInfo.model,
        'brand': androidInfo.brand,
        'version': androidInfo.version.release,
        'sdkInt': androidInfo.version.sdkInt,
      });
    } else if (isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      deviceInfo.addAll({
        'platform': 'iOS',
        'model': iosInfo.model,
        'name': iosInfo.name,
        'version': iosInfo.systemVersion,
      });
    }

    _cachedDeviceInfo = deviceInfo;
    return deviceInfo;
  }

  /// Get app info
  static Future<Map<String, String>> getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      'appName': packageInfo.appName,
      'packageName': packageInfo.packageName,
      'version': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };
  }

  /// Get screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Check if tablet
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = (size.width * size.width + size.height * size.height);
    return diagonal > 1100; // ~7 inches
  }

  /// Get orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}
