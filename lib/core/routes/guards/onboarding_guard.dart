// ════════════════════════════════════════════════════════════════
// 📁 lib/core/routes/guards/onboarding_guard.dart (ĐÃ SỬA)
// ════════════════════════════════════════════════════════════════
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../../core/storage/storage_service.dart';
import '../app_routes.dart';

@lazySingleton
class OnboardingGuard extends AutoRouteGuard {
  final StorageService _storageService;

  OnboardingGuard(this._storageService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final hasSeenOnboarding = _storageService.get<bool>('has_seen_onboarding') ?? false;

    if (hasSeenOnboarding) {
      resolver.next(true);
    } else {
      // Chỉ redirect, KHÔNG gọi next trong callback!
      resolver.redirect( OnboardingRoute());
      // Khi hoàn thành onboarding, hãy set 'has_seen_onboarding' và chuyển màn trong OnboardingPage.
    }
  }
}
