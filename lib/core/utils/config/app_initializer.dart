// lib/core/config/app_initializer.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template/core/config/env_config.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/di/register_services.dart';
import 'package:flutter_base_template/core/storage/local_storage.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class AppInitializer {
  /// Chuẩn bị toàn bộ trước khi chạy app
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 🔹 Logger
    Logger.configure(enabled: true, minLevel: LogLevel.debug);

    // 🔹 Storage
    await LocalStorage.getInstance();

    // 🔹 DI (Service Locator)
    await registerServices();

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

    // 3. Load environment
    const envFile = kReleaseMode ? '.env.production' : '.env.development';
    await EnvConfig.load(fileName: envFile);

    Logger.info('Environment: ${EnvConfig.environment}');
    Logger.info('API URL: ${EnvConfig.apiBaseUrl}');

    // 4. Setup DI
    await setupDependencyInjection();

    Logger.info('✅ App initialized successfully');

    // 🔹 (Optional) Thêm các init khác nếu cần
    // await Firebase.initializeApp();
    // await dotenv.load(fileName: ".env");

    debugPrint('✅ AppInitializer hoàn tất.');
  }
}
