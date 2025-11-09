// ════════════════════════════════════════════════════════════════
// 📁 lib/core/routes/guards/auth_guard.dart (ĐÃ SỬA)
// ════════════════════════════════════════════════════════════════
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../app_routes.dart';

@lazySingleton
class AuthGuard extends AutoRouteGuard {
  final AuthRepository _authRepository;

  AuthGuard(this._authRepository);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final result = await _authRepository.checkLoginStatus();

    result.fold(
      onSuccess: (isAuthenticated) {
        if (isAuthenticated) {
          // ✅ User authenticated
          resolver.next(true);
        } else {
          // ❌ Not authenticated, redirect to login
          resolver.redirect(const LoginRoute());
        }
      },
      onFailure: (error) {
        // ❌ Error, redirect to login
        resolver.redirect(const LoginRoute());
      },
    );
  }
}
