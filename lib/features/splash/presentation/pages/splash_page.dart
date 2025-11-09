import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/storage/storage_keys.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/app_version_service.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../core/utils/logger.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // ✅ Gọi trong initState thay vì addPostFrameCallback
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // ════════════════════════════════════════════════════════════
      // 1. Minimum splash duration (UX better)
      // ════════════════════════════════════════════════════════════
      await Future.wait([
        _checkAppVersion(),
        Future.delayed(const Duration(milliseconds: 1500)), // Minimum 1.5s
      ]);

      // ════════════════════════════════════════════════════════════
      // 2. Check routing logic
      // ════════════════════════════════════════════════════════════
      if (!mounted) return;
      await _handleRouting();
    } catch (e, stackTrace) {
      Logger.error('Splash initialization error: $e', stackTrace: stackTrace);

      // ✅ Fallback: Navigate to login on error
      if (mounted) {
        context.router.replace(const LoginRoute());
      }
    }
  }

  // ════════════════════════════════════════════════════════════════
  // Check app version & force update if needed
  // ════════════════════════════════════════════════════════════════
  Future<void> _checkAppVersion() async {
    try {
      final appVersionService = getIt<AppVersionService>();
      await appVersionService.checkForUpdate(context);
    } catch (e) {
      Logger.warning('App version check failed: $e');
      // Continue anyway - không block app vì version check
    }
  }

  // ════════════════════════════════════════════════════════════════
  // Handle routing logic based on app state
  // ════════════════════════════════════════════════════════════════
  Future<void> _handleRouting() async {
    final storageService = getIt<StorageService>();

    // Check states
    final isFirstRun = storageService.isFirstRun();
    final hasSeenOnboarding = storageService.get<bool>(StorageKeys.hasSeenOnboarding) ?? false;
    final isLoggedIn = storageService.isLoggedIn();

    // Log for debugging
    Logger.info(
      'Splash routing - FirstRun: $isFirstRun, '
      'Onboarding: $hasSeenOnboarding, '
      'LoggedIn: $isLoggedIn',
    );

    // Mark first run as completed
    if (isFirstRun) {
      await storageService.setFirstRun(false);
    }

    // ════════════════════════════════════════════════════════════
    // Routing priority:
    // 1. First time user → Onboarding
    // 2. Not logged in → Login
    // 3. Logged in → Main app
    // ════════════════════════════════════════════════════════════
    if (!mounted) return;

    if (isFirstRun || !hasSeenOnboarding) {
      // ✅ First time user
      Logger.info('→ Navigating to Onboarding');
      context.router.replace(OnboardingRoute());
    } else if (!isLoggedIn) {
      // ✅ User seen onboarding but not logged in
      Logger.info('→ Navigating to Login');
      context.router.replace(const LoginRoute());
    } else {
      // ✅ User logged in
      Logger.info('→ Navigating to Main App');
      context.router.replace(const BottomMenuRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ════════════════════════════════════════════════════════
            // Your App Logo
            // ════════════════════════════════════════════════════════
            const FlutterLogo(size: 100),

            const SizedBox(height: 32),

            // ════════════════════════════════════════════════════════
            // Loading indicator
            // ════════════════════════════════════════════════════════
            const CircularProgressIndicator(),

            const SizedBox(height: 16),

            // ════════════════════════════════════════════════════════
            // Loading text (optional)
            // ════════════════════════════════════════════════════════
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
