import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/services/navigation_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Singleton pattern
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  /// Kiểm tra 1 quyền có được cấp chưa
  Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// Yêu cầu 1 quyền, tự xử lý khi bị từ chối
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      await _showOpenSettingsDialog(permission);
    }
    return false;
  }

  /// Kiểm tra nhiều quyền
  Future<Map<Permission, bool>> checkMultiplePermissions(
      List<Permission> permissions) async {
    final results = <Permission, bool>{};
    for (final p in permissions) {
      results[p] = await checkPermission(p);
    }
    return results;
  }

  /// Yêu cầu nhiều quyền
  Future<Map<Permission, bool>> requestMultiplePermissions(
      List<Permission> permissions) async {
    final statuses = await permissions.request();
    final results = <Permission, bool>{};
    for (final entry in statuses.entries) {
      results[entry.key] = entry.value.isGranted;
      if (entry.value.isPermanentlyDenied) {
        await _showOpenSettingsDialog(entry.key);
      }
    }
    return results;
  }

  /// Mở phần cài đặt app nếu quyền bị từ chối vĩnh viễn
  Future<void> openAppSettingsManually() async {
    await openAppSettings();
  }

  /// Kiểm tra quyền camera
  Future<bool> checkCameraPermission() async =>
      await checkPermission(Permission.camera);

  /// Yêu cầu quyền camera
  Future<bool> requestCameraPermission() async =>
      await requestPermission(Permission.camera);

  /// Kiểm tra quyền gallery (storage/photos)
  Future<bool> checkGalleryPermission() async {
    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted) {
      return true;
    }
    return false;
  }

  /// Yêu cầu quyền gallery (storage/photos)
  Future<bool> requestGalleryPermission() async {
    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted) {
      return true;
    }
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  /// Kiểm tra quyền vị trí
  Future<bool> checkLocationPermission() async =>
      await checkPermission(Permission.locationWhenInUse);

  /// Yêu cầu quyền vị trí
  Future<bool> requestLocationPermission() async =>
      await requestPermission(Permission.locationWhenInUse);

  /// Kiểm tra quyền thông báo
  Future<bool> checkNotificationPermission() async =>
      await checkPermission(Permission.notification);

  /// Yêu cầu quyền thông báo
  Future<bool> requestNotificationPermission() async =>
      await requestPermission(Permission.notification);

  /// Kiểm tra quyền micro
  Future<bool> checkMicrophonePermission() async =>
      await checkPermission(Permission.microphone);

  /// Yêu cầu quyền micro
  Future<bool> requestMicrophonePermission() async =>
      await requestPermission(Permission.microphone);

  /// Hiển thị dialog mở cài đặt
  Future<void> _showOpenSettingsDialog(Permission permission) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: NavigationService().navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: const Text('Quyền bị từ chối'),
          content: const Text(
              'Bạn cần mở quyền trong phần Cài đặt để sử dụng tính năng này.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
              },
              child: const Text('Mở cài đặt'),
            ),
          ],
        ),
      );
    });
  }
}
