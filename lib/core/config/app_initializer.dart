// lib/core/config/app_initializer.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class AppInitializer {
  /// Chuẩn bị toàn bộ trước khi chạy app
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 🔹 Logger
    Logger.configure(enabled: true, minLevel: LogLevel.debug);

    // 🔹 UI / Orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // 4. Setup DI
    await configureDependencies();

    Logger.info('✅ App initialized successfully');

    // 🔹 (Optional) Thêm các init khác nếu cần
    // await Firebase.initializeApp();
    // await dotenv.load(fileName: ".env");

    debugPrint('✅ AppInitializer hoàn tất.');
  }
}
