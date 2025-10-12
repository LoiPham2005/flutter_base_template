// lib/core/config/initialize_app.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class InitializeApp {
  /// Cấu hình hệ thống và UI trước khi chạy ứng dụng
  static Future<void> initialize() async {
    // ✅ Giữ ứng dụng chỉ chạy dọc
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // ✅ Cấu hình thanh trạng thái & thanh điều hướng
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // làm trong suốt
        statusBarIconBrightness: Brightness.dark, // icon màu tối
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // ✅ Cấu hình Logger
    Logger.configure(
      enabled: true,
      minLevel: LogLevel.debug,
    );

    // ✅ (Tuỳ chọn) kiểm tra môi trường hoặc theme ở đây
    debugPrint("✅ AppInitializer: System UI configured successfully.");
  }
}
