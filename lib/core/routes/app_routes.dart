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
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      // GoRoute(
      //   path: category,
      //   builder: (context, state) => const CategoryPage(),
      //   routes: [
      //     GoRoute(
      //       path: ':id',
      //       builder: (context, state) {
      //         final id = state.pathParameters['id'];
      //         return CategoryDetailPage(categoryId: id ?? '');
      //       },
      //     ),
      //   ],
      // ),
    ],
  );
}
