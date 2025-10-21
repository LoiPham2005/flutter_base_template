import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/constants/app_constants.dart';
import 'package:flutter_base_template/core/storage/storage_service.dart';
import 'package:flutter_base_template/core/utils/check_internet.dart';
import 'package:flutter_base_template/core/utils/check_version.dart';
import 'package:flutter_base_template/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_base_template/features/bottom_menu/presentation/pages/bottom_menu.dart';
import 'package:flutter_base_template/features/welcome/presentation/pages/welcom_page.dart';
import 'package:get/get.dart';
import 'package:flutter_base_template/core/di/injection.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<void> _initializeApp(BuildContext context) async {
    try {
      // Check internet trước
      final hasInternet = await CheckInternet.hasConnection();
      if (!hasInternet) {
        await CheckInternet.check(
          context,
          showMessage: true,
          onConnected: () async {
            // Tiếp tục khởi tạo khi có internet
            await _continueInitialization(context);
          },
        );
      } else {
        // Có internet, tiếp tục khởi tạo
        await _continueInitialization(context);
      }
    } catch (e) {
      print('Error initializing app: $e');
      // Fallback nếu có lỗi
      await _continueInitialization(context);
    }
  }

  Future<void> _continueInitialization(BuildContext context) async {
    try {
      // Lấy instance của StorageService từ DI
      final storageService = getIt<StorageService>();

      // Check version
      await CheckVersion.check(
        context,
        androidPackageId: AppConstants.androidPackageId,
        iosBundleId: AppConstants.iosBundleId,
      );

      final firstRun = storageService.isFirstRun();
      final loggedIn = storageService.isLoggedIn();

      // Nếu là lần đầu chạy, set lại để lần sau không vào nữa
      if (firstRun) {
        await storageService.setFirstRun(false);
      }

      if (firstRun) {
        Get.offAll(() => const WelcomPage());
      } else {
        if (loggedIn) {
          Get.offAll(() => const BottomMenu());
        } else {
          Get.offAll(() => const LoginPage());
        }
      }
    } catch (e) {
      print('Error in continuation: $e');
      // Fallback về login page nếu có lỗi
      Get.offAll(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Khởi tạo app sau khi build hoàn tất
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp(context);
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/image/SprotHub_Logo.png',
            //   width: 120,
            //   height: 120,
            // ),
            // const SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
