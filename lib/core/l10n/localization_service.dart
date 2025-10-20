import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import '../storage/storage_service.dart';
import '../storage/storage_keys.dart';

@lazySingleton
class LocalizationService {
  LocalizationService(this._storageService);
  final StorageService _storageService;

  // Observable locale state
  final _currentLocale = const Locale('vi').obs;
  Locale get currentLocale => _currentLocale.value;

  // Supported locales
  static const supportedLanguages = {
    'vi': 'Tiếng Việt',
    'en': 'English',
    'ja': '日本語',
  };

  // Khởi tạo locale từ storage
  Future<void> initLocale() async {
    final savedLocale = _storageService.get<String>(StorageKeys.languageCode);
    if (savedLocale != null && supportedLanguages.containsKey(savedLocale)) {
      await changeLocale(savedLocale);
    }
  }

  // Thay đổi ngôn ngữ
  Future<void> changeLocale(String languageCode) async {
    if (!supportedLanguages.containsKey(languageCode)) return;

    final newLocale = Locale(languageCode);
    if (newLocale == _currentLocale.value) return;

    _currentLocale.value = newLocale;
    await _storageService.set(StorageKeys.languageCode, languageCode);
    Get.updateLocale(newLocale);
  }

  // Lấy tên ngôn ngữ hiện tại
  String getCurrentLanguageName() {
    return supportedLanguages[currentLocale.languageCode] ?? 'Unknown';
  }
}
