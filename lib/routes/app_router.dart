import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/services/navigation_service.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash, // Route mặc định khi khởi động app
  navigatorKey: NavigationService().navigatorKey,

  redirect: (context, state) {
    final isLoggedIn = false; // Kiểm tra token ở đây
    final loggingIn = state.matchedLocation == AppRoutes.login;

    if (!isLoggedIn && !loggingIn) return AppRoutes.login;
    if (isLoggedIn && loggingIn) return AppRoutes.home;
    return null;
  },

  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    // GoRoute(
    //   path: AppRoutes.login,
    //   builder: (context, state) => const LoginPage(),
    // ),
    // Thêm các routes khác

    
  ],
);
