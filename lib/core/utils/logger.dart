// lib/core/utils/logger.dart
import 'dart:developer' as developer;

import 'package:flutter_base_template/core/config/env_config.dart';

enum LogLevel { debug, info, warning, error }

class Logger {
  Logger._();

  static bool _enabled = true;
  static LogLevel _minLevel = LogLevel.debug;

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
    if (EnvConfig.enableLogging) {
      // ✅ Từ .env
      developer.log('ℹ️ $message', name: 'APP');
    }
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
    _log(
      LogLevel.error,
      message,
      tag: tag,
      data: error,
      stackTrace: stackTrace,
    );
  }

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
      error: data,
      stackTrace: stackTrace,
      level: _getLogLevel(level),
    );
  }

  static String _getPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛 DEBUG';
      case LogLevel.info:
        return 'ℹ️ INFO';
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
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
}
