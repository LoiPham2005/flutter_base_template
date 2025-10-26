// lib/app/app_observer.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class AppObserver with WidgetsBindingObserver {
  static final AppObserver _instance = AppObserver._internal();
  factory AppObserver() => _instance;
  AppObserver._internal();

  // Thêm các callback để các service khác có thể subscribe
  final _onResumeCallbacks = <Function>[];
  final _onPauseCallbacks = <Function>[];

  void addOnResumeCallback(Function callback) {
    _onResumeCallbacks.add(callback);
  }

  void addOnPauseCallback(Function callback) {
    _onPauseCallbacks.add(callback);
  }

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    Logger.info('✅ AppLifecycleObserver initialized');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Logger.info('🔄 App lifecycle changed: $state');
    
    switch (state) {
      case AppLifecycleState.resumed:
        Logger.info('📱 App resumed (foreground)');
        for (final callback in _onResumeCallbacks) {
          callback();
        }
        break;
        
      case AppLifecycleState.paused:
        Logger.info('⏸️ App paused (background)');
        for (final callback in _onPauseCallbacks) {
          callback();
        }
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

  void dispose() {
    _onResumeCallbacks.clear();
    _onPauseCallbacks.clear();
    WidgetsBinding.instance.removeObserver(this);
  }
}
