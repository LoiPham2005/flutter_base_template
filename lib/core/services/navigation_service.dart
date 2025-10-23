// lib/core/services/navigation_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/l10n/generated/app_localizations.dart';

class NavigationService {
  factory NavigationService() => _instance;
  NavigationService._internal();
  static final NavigationService _instance = NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentContext;
  NavigatorState? get navigator => navigatorKey.currentState;

  // AppLocalizations? get l10n =>
  //     context != null ? AppLocalizations.of(context!) : null;

  // // Theme
  // ThemeData? get theme => context != null ? Theme.of(context!) : null;
  // TextTheme? get textTheme =>
  //     context != null ? Theme.of(context!).textTheme : null;
  // ColorScheme? get colorScheme =>
  //     context != null ? Theme.of(context!).colorScheme : null;

  // // Colors
  // Color? get primaryColor => theme?.primaryColor;
  // Color? get accentColor => colorScheme?.secondary;
  // Color? get scaffoldBackgroundColor => theme?.scaffoldBackgroundColor;
  // Color? get cardColor => theme?.cardColor;

  // Push
  Future<T?>? push<T>(Widget page) {
    return navigator?.push<T>(MaterialPageRoute(builder: (_) => page));
  }

  Future<T?>? pushNamed<T>(String routeName, {Object? arguments}) {
    return navigator?.pushNamed<T>(routeName, arguments: arguments);
  }

  // Push replacement
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

  // Push and remove until
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

  // Pop
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

  // Pop to root
  void popToRoot() {
    navigator?.popUntil((route) => route.isFirst);
  }

 
  // ===============================
  // Focus
  // ===============================

  void unfocus() {
    context != null ? FocusScope.of(context!).unfocus() : null;
  }

  void requestFocus(FocusNode node) {
    if (context != null) FocusScope.of(context!).requestFocus(node);
  }

}
