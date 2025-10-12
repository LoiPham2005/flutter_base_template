// lib/app/app_widget_binding.dart
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/storage/local_storage.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:flutter_base_template/core/di/register_services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppWidgetBinding {
  /// Khởi tạo toàn bộ các thành phần quan trọng của ứng dụng
  static Future<void> ensureInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();

    // ✅ Khởi tạo logger
    Logger.configure(enabled: true, minLevel: LogLevel.debug);

    // ✅ Khởi tạo Local Storage
    await LocalStorage.getInstance();

    // ✅ Đăng ký Dependency Injection
    await setupDependencyInjection();

    // ✅ Nếu có Firebase
    // await Firebase.initializeApp();

    // ✅ Nếu có .env (biến môi trường)
    // await dotenv.load(fileName: ".env");

    // Bạn có thể thêm các khởi tạo khác ở đây, ví dụ:
    // await NotificationService().initialize();
  }

  /// Helper gộp DI setup
  static Future<void> setupDependencyInjection() async {
    await registerServices();
  }
}
