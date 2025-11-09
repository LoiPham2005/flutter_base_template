// ════════════════════════════════════════════════════════════════
// 📁 lib/core/routes/app_routes.dart - BEST FOR YOUR PROJECT ✅
// ════════════════════════════════════════════════════════════════
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

// Import pages
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/splash/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/bottom_menu/presentation/pages/bottom_menu_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

part 'app_routes.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    // Splash - Entry point, handle all routing logic here
    AutoRoute(page: SplashRoute.page, initial: true),

    // Onboarding
    AutoRoute(page: OnboardingRoute.page),

    // Auth
    AutoRoute(page: LoginRoute.page),

    // Main app with tabs
    AutoRoute(
      page: BottomMenuRoute.page,
      children: <AutoRoute>[
        AutoRoute(page: HomeRoute.page, initial: true),
      ],
    ),
  ];
}
