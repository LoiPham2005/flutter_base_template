// class AppRoutes {
//   static const splash = '/';
//   static const login = '/login';
//   static const home = '/home';
//   static const settings = '/settings';
// }


import 'package:flutter_base_template/core/services/navigation_service.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';

  static final router = GoRouter(
  initialLocation: splash, // Route mặc định khi khởi động app
  navigatorKey: NavigationService().navigatorKey,

  redirect: (context, state) {
    final isLoggedIn = false; // Kiểm tra token ở đây
    final loggingIn = state.matchedLocation == login;

    if (!isLoggedIn && !loggingIn) return login;
    if (isLoggedIn && loggingIn) return home;
    return null;
  },

  routes: [
    GoRoute(
      path: home,
      builder: (context, state) => const HomePage(),
    ),
    // GoRoute(
    //   path: AppRoutes.login,
    //   builder: (context, state) => const LoginPage(),
    // ),
    // Thêm các routes khác

    
  ],
  );
}
