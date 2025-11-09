// ════════════════════════════════════════════════════════════════
// 📁 lib/core/routes/app_routes.dart (ĐÃ SỬA)
// ════════════════════════════════════════════════════════════════
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/features/bottom_menu/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_base_template/features/splash/presentation/pages/onboarding_page.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'guards/auth_guard.dart';
import 'guards/onboarding_guard.dart';

part 'app_routes.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {  // ✅ Đổi từ $_AppRouter
  final AuthGuard _authGuard;
  final OnboardingGuard _onboardingGuard;

  AppRouter(this._authGuard, this._onboardingGuard);

  @override
  List<AutoRoute> get routes => [
    // ════════════════════════════════════════════════════════════
    // PUBLIC ROUTES
    // ════════════════════════════════════════════════════════════
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
      initial: true,  // ✅ Login là initial nếu chưa auth
    ),

    AutoRoute(
      page: OnboardingRoute.page,
      path: '/onboarding',
    ),

    // ════════════════════════════════════════════════════════════
    // PROTECTED ROUTES (require auth)
    // ════════════════════════════════════════════════════════════
    AutoRoute(
      page: BottomMenuRoute.page,  // ✅ Sửa tên route
      path: '/',
      guards: [_onboardingGuard, _authGuard],
      children: [
        AutoRoute(
          page: HomeRoute.page,
          path: 'home',
          initial: true,
        ),
        // AutoRoute(
        //   page: ProfileRoute.page,
        //   path: 'profile',
        // ),
        // AutoRoute(
        //   page: SettingsRoute.page,
        //   path: 'settings',
        // ),
      ],
    ),
  ];
}
