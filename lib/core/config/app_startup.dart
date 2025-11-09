// ════════════════════════════════════════════════════════════════
// 📁 lib/core/config/app_startup.dart (FIXED)
// ════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/extensions/context_extensions.dart';
import 'package:flutter_base_template/core/network/network_info.dart';
import 'package:flutter_base_template/core/services/app_version_service.dart';
import 'package:flutter_base_template/core/services/network_monitor.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/utils/logger.dart';
import 'package:flutter_base_template/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_base_template/features/bottom_menu/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_base_template/features/welcome/presentation/pages/welcom_page.dart';

/// AppStartup: xử lý logic sau khi AppInitializer xong
class AppStartup {
  static Future<void> launch(BuildContext context) async {
    try {
      // ✅ Sử dụng NetworkInfo (DI) thay vì NetworkMonitor
      final networkInfo = getIt<NetworkInfo>();
      final hasInternet = await networkInfo.isConnected;

      if (!hasInternet) {
        Logger.warning('Không có kết nối internet. Đang chờ kết nối lại...');

        // ✅ Dùng NetworkMonitor cho UI feedback
        await NetworkMonitor().startMonitoring(
          context,
          showSnackBar: true,
          onConnected: () async {
            Logger.info('Đã có kết nối internet. Tiếp tục khởi tạo ứng dụng...');
            await _continue(context);
          },
        );
      } else {
        await _continue(context);
      }
    } catch (e, s) {
      Logger.error('Lỗi khi khởi tạo ứng dụng: $e', stackTrace: s);
      await _continue(context);
    }
  }

  static Future<void> _continue(BuildContext context) async {
    final storageService = getIt<StorageService>();
    final appVersionService = AppVersionService();

    // 🔹 Kiểm tra cập nhật version
    await appVersionService.checkForUpdate(context);

    // 🔹 Kiểm tra trạng thái người dùng
    final firstRun = storageService.isFirstRun();
    final loggedIn = storageService.isLoggedIn();

    if (firstRun) await storageService.setFirstRun(false);

    // 🔹 Điều hướng
    if (!context.mounted) return;

    if (firstRun) {
      context.pushReplacement(const WelcomPage());
    } else {
      if (loggedIn) {
        context.pushReplacement(const BottomMenuPage());
      } else {
        context.pushReplacement(const LoginPage());
      }
    }
  }
}
