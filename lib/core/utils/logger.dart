// lib/core/utils/logger.dart
import 'dart:developer' as developer;

enum LogLevel { debug, info, success, warning, error }

class Logger {
  Logger._();

  static bool _enabled = true;
  static LogLevel _minLevel = LogLevel.debug;

  /// Cấu hình logger (tắt/mở và mức log tối thiểu)
  static void configure({
    bool enabled = true,
    LogLevel minLevel = LogLevel.debug,
  }) {
    _enabled = enabled;
    _minLevel = minLevel;
  }

  static void debug(String message, {String? tag, dynamic data}) {
    _log(LogLevel.debug, message, tag: tag, data: data);
  }

  static void info(String message, {String? tag, dynamic data}) {
    _log(LogLevel.info, message, tag: tag, data: data);
  }

  static void success(String message, {String? tag, dynamic data}) {
    _log(LogLevel.success, message, tag: tag, data: data);
  }

  static void warning(String message, {String? tag, dynamic data}) {
    _log(LogLevel.warning, message, tag: tag, data: data);
  }

  static void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.error, message, tag: tag, data: error, stackTrace: stackTrace);
  }

  /// --- CORE ---
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    dynamic data,
    StackTrace? stackTrace,
  }) {
    if (!_enabled || level.index < _minLevel.index) return;

    final prefix = _getPrefix(level);
    final tagStr = tag != null ? '[$tag] ' : '';
    final logMessage = '$prefix $tagStr$message';

    developer.log(
      logMessage,
      name: 'APP',
      level: _getLogLevel(level),
      error: data,
      stackTrace: stackTrace,
    );

    if (data != null) {
      developer.log('📦 Data: $data', name: 'APP', level: _getLogLevel(level));
    }
  }

  static String _getPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛 DEBUG';
      case LogLevel.info:
        return 'ℹ️ INFO';
      case LogLevel.success:
        return '✅ SUCCESS';
      case LogLevel.warning:
        return '⚠️ WARNING';
      case LogLevel.error:
        return '❌ ERROR';
    }
  }

  static int _getLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.success:
        return 850;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
}
