// ════════════════════════════════════════════════════════════════
// 📁 lib/core/config/app_observer.dart (TỐI ƯU LOGGER)
// ════════════════════════════════════════════════════════════════
import 'package:flutter/widgets.dart';
import 'package:flutter_base_template/core/config/environment_config.dart';
import 'package:flutter_base_template/core/utils/logger.dart';

class AppObserver with WidgetsBindingObserver {
  static final AppObserver _instance = AppObserver._internal();
  factory AppObserver() => _instance;
  AppObserver._internal();

  bool _isInitialized = false;
  final List<VoidCallback> _onResumeCallbacks = [];
  final List<VoidCallback> _onPauseCallbacks = [];

  void addOnResumeCallback(VoidCallback callback) {
    if (!_onResumeCallbacks.contains(callback)) {
      _onResumeCallbacks.add(callback);
    }
  }

  void addOnPauseCallback(VoidCallback callback) {
    if (!_onPauseCallbacks.contains(callback)) {
      _onPauseCallbacks.add(callback);
    }
  }

  void removeOnResumeCallback(VoidCallback callback) {
    _onResumeCallbacks.remove(callback);
  }

  void removeOnPauseCallback(VoidCallback callback) {
    _onPauseCallbacks.remove(callback);
  }

  void initialize() {
    if (_isInitialized) return;

    WidgetsBinding.instance.addObserver(this);
    _isInitialized = true;
    // ✅ GIẢM: Bỏ log này (không cần thiết)
    // Logger.info('✅ AppLifecycleObserver initialized');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ✅ GIẢM: CHỈ log nếu là Dev mode
    if (EnvironmentConfig.isDev) {
      Logger.debug('🔄 Lifecycle: ${state.name}');
    }

    void executeCallbacks(List<VoidCallback> callbacks, String type) {
      for (final callback in callbacks) {
        try {
          callback();
        } catch (e, stackTrace) {
          // ✅ GIỮ: Log error (quan trọng)
          Logger.error(
            '❌ Error in $type callback',
            error: e,
            stackTrace: stackTrace,
          );
        }
      }
    }

    switch (state) {
      // case AppLifecycleState.resumed:
      //   Logger.info('📱 App resumed (foreground)');
      //   _executeCallbacks(_onResumeCallbacks, 'resume');
      //   break;

      // case AppLifecycleState.paused:
      //   Logger.info('⏸️ App paused (background)');
      //   _executeCallbacks(_onPauseCallbacks, 'pause');
      //   break;

      // case AppLifecycleState.detached:
      //   Logger.info('❌ App detached (closed)');
      //   break;

      // case AppLifecycleState.inactive:
      //   Logger.info('⚪ App inactive (temporary)');
      //   break;

      // case AppLifecycleState.hidden:
      //   Logger.info('👻 App hidden');
      //   break;
      
      case AppLifecycleState.resumed:
        // ✅ GIẢM: Bỏ log này (quá nhiều)
        // Logger.info('📱 App resumed (foreground)');
        executeCallbacks(_onResumeCallbacks, 'resume');
        break;

      case AppLifecycleState.paused:
        // ✅ GIẢM: Bỏ log này (quá nhiều)
        // Logger.info('⏸️ App paused (background)');
        executeCallbacks(_onPauseCallbacks, 'pause');
        break;

      case AppLifecycleState.detached:
        // ✅ GIỮ: Log detached (quan trọng)
        if (EnvironmentConfig.isDev) {
          Logger.info('❌ App detached');
        }
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        // ✅ GIẢM: Bỏ log này (không quan trọng)
        break;
    }
  }

  void dispose() {
    if (!_isInitialized) return;

    _onResumeCallbacks.clear();
    _onPauseCallbacks.clear();
    WidgetsBinding.instance.removeObserver(this);
    _isInitialized = false;
    // ✅ GIẢM: Bỏ log này (không cần thiết)
    // Logger.info('AppObserver disposed');
  }
}
