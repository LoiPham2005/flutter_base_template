import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/storage/storage_core.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import '../storage/storage_service.dart';
import '../storage/storage_keys.dart';
import 'app_localization_delegate_config.dart';

@lazySingleton
class LocalizationService {
  final StorageCore _storagecore;

  LocalizationService(this._storagecore);

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
    final savedLocale = _storagecore.get<String>(StorageKeys.languageCode);
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
    await _storagecore.set(StorageKeys.languageCode, languageCode);
    Get.updateLocale(newLocale);
  }

  // Lấy tên ngôn ngữ hiện tại
  String getCurrentLanguageName() {
    return supportedLanguages[currentLocale.languageCode] ?? 'Unknown';
  }
}