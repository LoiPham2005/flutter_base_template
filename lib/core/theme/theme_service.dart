import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import '../storage/storage_service.dart';
import '../storage/storage_keys.dart';
import '../theme/app_theme.dart';

@lazySingleton
class ThemeService {
  final StorageService _storageService;
  
  ThemeService(this._storageService);

  // Observable theme state
  final _currentTheme = AppThemeKey.light.obs;
  ThemeMode get currentThemeMode => _getThemeMode(_currentTheme.value);
  bool get isDarkMode => currentThemeMode == ThemeMode.dark;

  // Khởi tạo theme từ storage
  Future<void> initTheme() async {
    final savedTheme = _storageService.getThemeMode();
    if (savedTheme != null) {
      _currentTheme.value = AppThemeKey.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => AppThemeKey.light,
      );
    }
  }

  // Chuyển đổi giữa Light/Dark theme
  Future<void> toggleTheme() async {
    final newTheme = isDarkMode ? AppThemeKey.light : AppThemeKey.dark;
    await changeTheme(newTheme);
  }

  // Thay đổi sang theme cụ thể
  Future<void> changeTheme(AppThemeKey themeKey) async {
    _currentTheme.value = themeKey;
    await _storageService.saveThemeMode(themeKey.toString());
    Get.changeThemeMode(_getThemeMode(themeKey));
  }

  // Helper
  ThemeMode _getThemeMode(AppThemeKey key) {
    switch (key) {
      case AppThemeKey.dark:
        return ThemeMode.dark;
      case AppThemeKey.light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}