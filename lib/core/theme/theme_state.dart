import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/theme/app_theme.dart';

class ThemeState {
  final AppThemeKey currentTheme;
  final ThemeMode themeMode;

  const ThemeState({
    this.currentTheme = AppThemeKey.light,
    this.themeMode = ThemeMode.light,
  });

  ThemeState copyWith({
    AppThemeKey? currentTheme,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      currentTheme: currentTheme ?? this.currentTheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState &&
        other.currentTheme == currentTheme &&
        other.themeMode == themeMode;
  }

  @override
  int get hashCode => currentTheme.hashCode ^ themeMode.hashCode;

  @override
  String toString() =>
      'ThemeState(currentTheme: $currentTheme, themeMode: $themeMode)';
}
