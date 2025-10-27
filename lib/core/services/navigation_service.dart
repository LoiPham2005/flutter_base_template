// ════════════════════════════════════════════════════════════════
// 📁 lib/core/services/navigation_service.dart (TỐI ƯU - CHỈ GLOBAL)
// ════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

/// Global navigation service - CHỈ dùng khi KHÔNG CÓ BuildContext
/// 
/// ⚠️ LƯU Ý: Ưu tiên dùng context.push() thay vì service này!
/// 
/// Use cases cho NavigationService:
/// - Từ background services (FCM, notifications)
/// - Từ business logic layer (không có context)
/// - Từ static methods/callbacks
class NavigationService {
  NavigationService._();
  static final NavigationService _instance = NavigationService._();
  factory NavigationService() => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentContext;
  NavigatorState? get navigator => navigatorKey.currentState;

  // ═══════════════════════════════════════════════════════════════
  // PUSH METHODS
  // ═══════════════════════════════════════════════════════════════

  Future<T?>? push<T>(Widget page) {
    return navigator?.push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?>? pushNamed<T>(String routeName, {Object? arguments}) {
    return navigator?.pushNamed<T>(routeName, arguments: arguments);
  }

  // ═══════════════════════════════════════════════════════════════
  // PUSH REPLACEMENT METHODS
  // ═══════════════════════════════════════════════════════════════

  Future<T?>? pushReplacement<T, TO>(Widget page, {TO? result}) {
    return navigator?.pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  Future<T?>? pushReplacementNamed<T, TO>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigator?.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // PUSH AND REMOVE UNTIL METHODS
  // ═══════════════════════════════════════════════════════════════

  Future<T?>? pushAndRemoveUntil<T>(
    Widget page,
    bool Function(Route<dynamic>) predicate,
  ) {
    return navigator?.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      predicate,
    );
  }

  Future<T?>? pushNamedAndRemoveUntil<T>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigator?.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // POP METHODS
  // ═══════════════════════════════════════════════════════════════

  void pop<T>([T? result]) {
    navigator?.pop<T>(result);
  }

  void popUntil(bool Function(Route<dynamic>) predicate) {
    navigator?.popUntil(predicate);
  }

  bool canPop() {
    return navigator?.canPop() ?? false;
  }

  void maybePop<T>([T? result]) {
    navigator?.maybePop<T>(result);
  }

  void popToRoot() {
    navigator?.popUntil((route) => route.isFirst);
  }

  // ═══════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Unfocus keyboard globally
  void unfocus() {
    if (context != null) {
      FocusScope.of(context!).unfocus();
    }
  }

  /// Request focus globally
  void requestFocus(FocusNode node) {
    if (context != null) {
      FocusScope.of(context!).requestFocus(node);
    }
  }

  /// Check if context is available
  bool get hasContext => context != null;

  /// Get current route name
  String? get currentRouteName {
    final route = ModalRoute.of(context!);
    return route?.settings.name;
  }
}