// lib/app/app_observer.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class AppObserver with WidgetsBindingObserver {
  static final AppObserver _instance = AppObserver._internal();
  factory AppObserver() => _instance;
  AppObserver._internal();

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    Logger.info('✅ AppLifecycleObserver initialized');
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Logger.info('🔄 App lifecycle changed: $state');
    switch (state) {
      case AppLifecycleState.resumed:
        Logger.info('📱 App resumed (foreground)');
        break;
      case AppLifecycleState.paused:
        Logger.info('⏸️ App paused (background)');
        break;
      case AppLifecycleState.detached:
        Logger.info('❌ App detached (closed)');
        break;
      case AppLifecycleState.inactive:
        Logger.info('⚪ App inactive (temporary)');
        break;
      case AppLifecycleState.hidden:
        Logger.info('👻 App hidden');
        break;
    }
  }
}
