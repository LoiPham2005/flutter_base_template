import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_template/core/services/navigation_service.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base_template/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_base_template/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_base_template/features/home/presentation/pages/home_page.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String category = '/category';
  static const String categoryDetail = '/category/:id';

  final GoRouter router = GoRouter(
    // 🏁 Đường dẫn mặc định khi app khởi động
    initialLocation: '/',

    // 🔑 Dùng cho điều hướng toàn cục (Global navigation)
    navigatorKey: NavigationService().navigatorKey,

    // 🗺️ Danh sách các route được khai báo
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],

    // 🚪 Chạy khi người dùng truy cập vào route không tồn tại
    errorBuilder: (context, state) => const NotFoundPage(),

    // ⚙️ Cho phép ghi log GoRouter (hữu ích khi debug)
    debugLogDiagnostics: true,

    // 🔄 Khi có thay đổi trong trạng thái app (VD: auth, theme...)
    // refreshListenable: GoRouterRefreshStream(authBloc.stream),

    // 🧭 Chạy khi cần điều hướng thủ công (trước khi vào route)
    // redirect: (BuildContext context, GoRouterState state) {
    //   final loggedIn = authBloc.state is Authenticated;
    //   final isLoggingIn = state.uri.toString() == '/login';

    //   if (!loggedIn && !isLoggingIn) return '/login';
    //   if (loggedIn && isLoggingIn) return '/home';
    //   return null;
    // },

    // 📍 Dành cho Deep Links (Android, iOS, web)
    // urlPathStrategy: UrlPathStrategy.path,

    // 📱 Điều chỉnh hoạt động của router khi back/forward
    restorationScopeId: 'app_router',
  );
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '404 - Không tìm thấy trang',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
    );
  }
}
