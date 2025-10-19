import 'package:flutter/material.dart';
import 'localization_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizationConfig {
  // Ngôn ngữ mặc định
  static const Locale defaultLocale = Locale('vi');

  // Các ngôn ngữ được hỗ trợ
  static const List<Locale> supportedLocales = [
    Locale('vi'),
    Locale('en'),
    Locale('ja'),
  ];

  // Các delegate
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
