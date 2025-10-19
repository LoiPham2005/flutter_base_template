import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/storage/shared_preferences/app_preferences.dart';
import 'package:flutter_base_template/core/utils/check_internet.dart';
import 'package:flutter_base_template/core/utils/check_version.dart';
import 'package:flutter_base_template/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_base_template/features/bottom_menu/presentation/pages/bottom_menu.dart';
import 'package:flutter_base_template/features/welcome/presentation/pages/welcom_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      print("Error initializing app: $e");
      // Fallback nếu có lỗi
      await _continueInitialization(context);
    }
  }

  Future<void> _continueInitialization(BuildContext context) async {
    try {
      // Check version
      await CheckVersion.check(
        context,
        androidPackageId: 'com.example.dat_san_247_mobile',
        iosBundleId: 'com.example.dat_san_247_mobile',
      );

      final firstRun = await AppPreferences.isFirstRun();
      final loggedIn = await AppPreferences.isLogin();

      print("isFirstRun: $firstRun");
      print("isLogin: $loggedIn");

      if (firstRun) {
        await Get.offAll(() => const WelcomPage());
      } else {
        if (loggedIn) {
          await Get.offAll(() => const BottomMenu());
        } else {
          await Get.offAll(() => const LoginPage());
        }
      }
    } catch (e) {
      print("Error in continuation: $e");
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

    return Scaffold(
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
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
