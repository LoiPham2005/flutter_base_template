import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'theme_state.dart';

@injectable
@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._storageService) : super(const ThemeState());
  final StorageService _storageService;

  bool get isDarkMode => state.themeMode == ThemeMode.dark;

  Future<void> initTheme() async {
    final savedTheme = _storageService.getThemeMode();
    if (savedTheme != null) {
      final themeKey = AppThemeKey.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => AppThemeKey.light,
      );
      await _changeTheme(themeKey);
    }
  }

  Future<void> toggleTheme() async {
    final newTheme = isDarkMode ? AppThemeKey.light : AppThemeKey.dark;
    await _changeTheme(newTheme);
  }

  Future<void> _changeTheme(AppThemeKey themeKey) async {
    final themeMode = _getThemeMode(themeKey);
    await _storageService.saveThemeMode(themeKey.toString());

    emit(state.copyWith(currentTheme: themeKey, themeMode: themeMode));
  }

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
