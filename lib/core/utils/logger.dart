// // lib/core/utils/logger.dart
// import 'dart:developer' as developer;

// enum LogLevel { debug, info, success, warning, error }

// class Logger {
//   Logger._();

//   static bool _enabled = true;
//   static LogLevel _minLevel = LogLevel.debug;

//   /// Cấu hình logger (tắt/mở và mức log tối thiểu)
//   static void configure({
//     bool enabled = true,
//     LogLevel minLevel = LogLevel.debug,
//   }) {
//     _enabled = enabled;
//     _minLevel = minLevel;
//   }

//   static void debug(String message, {String? tag, dynamic data}) {
//     _log(LogLevel.debug, message, tag: tag, data: data);
//   }

//   static void info(String message, {String? tag, dynamic data}) {
//     _log(LogLevel.info, message, tag: tag, data: data);
//   }

//   static void success(String message, {String? tag, dynamic data}) {
//     _log(LogLevel.success, message, tag: tag, data: data);
//   }

//   static void warning(String message, {String? tag, dynamic data}) {
//     _log(LogLevel.warning, message, tag: tag, data: data);
//   }

//   static void error(
//     String message, {
//     String? tag,
//     dynamic error,
//     StackTrace? stackTrace,
//   }) {
//     _log(LogLevel.error, message, tag: tag, data: error, stackTrace: stackTrace);
//   }

//   /// --- CORE ---
//   static void _log(
//     LogLevel level,
//     String message, {
//     String? tag,
//     dynamic data,
//     StackTrace? stackTrace,
//   }) {
//     if (!_enabled || level.index < _minLevel.index) return;

//     final prefix = _getPrefix(level);
//     final tagStr = tag != null ? '[$tag] ' : '';
//     final logMessage = '$prefix $tagStr$message';

//     developer.log(
//       logMessage,
//       name: 'APP',
//       level: _getLogLevel(level),
//       error: data,
//       stackTrace: stackTrace,
//     );

//     if (data != null) {
//       developer.log('📦 Data: $data', name: 'APP', level: _getLogLevel(level));
//     }
//   }

//   static String _getPrefix(LogLevel level) {
//     switch (level) {
//       case LogLevel.debug:
//         return '🐛 DEBUG';
//       case LogLevel.info:
//         return 'ℹ️ INFO';
//       case LogLevel.success:
//         return '✅ SUCCESS';
//       case LogLevel.warning:
//         return '⚠️ WARNING';
//       case LogLevel.error:
//         return '❌ ERROR';
//     }
//   }

//   static int _getLogLevel(LogLevel level) {
//     switch (level) {
//       case LogLevel.debug:
//         return 500;
//       case LogLevel.info:
//         return 800;
//       case LogLevel.success:
//         return 850;
//       case LogLevel.warning:
//         return 900;
//       case LogLevel.error:
//         return 1000;
//     }
//   }
// }

// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/logger.dart
// ════════════════════════════════════════════════════════════════
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class LogConfig {
  static bool enableHttpLogs = kDebugMode; // Chỉ log HTTP ở debug mode
  static bool enableBlocLogs = kDebugMode; // Chỉ log Bloc ở debug mode
  static bool enableErrorLogs = true; // Luôn log error
  static bool enableDetailedErrors = kDebugMode; // Stack trace chi tiết
  static bool enableSuccessLogs = false; // Tắt log success mặc định

  /// Chỉ log HTTP response khi có lỗi
  static bool logOnlyFailedRequests = true;

  static int maxStackTraceLines = 3;
}

/// Logger đơn giản, tập trung
class Logger {
  Logger._();

  static const _prefix = '[APP]';

  // ═══════════════════════════════════════════════════════════════
  // GENERAL LOGS (luôn hiển thị ở debug mode)
  // ═══════════════════════════════════════════════════════════════

  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      developer.log('ℹ️ $tagStr$message', name: _prefix);
    }
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      developer.log('⚠️ $tagStr$message', name: _prefix);
    }
  }

  static void success(String message, {String? tag}) {
    if (LogConfig.enableSuccessLogs && kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      developer.log('✅ $tagStr$message', name: _prefix);
    }
  }

  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      developer.log('🐛 $tagStr$message', name: _prefix);
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // ERROR LOGS (luôn hiển thị)
  // ═══════════════════════════════════════════════════════════════

  /// Log lỗi với format rõ ràng
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!LogConfig.enableErrorLogs) return;

    final buffer = StringBuffer();
    final tagStr = tag != null ? '[$tag] ' : '';

    buffer.writeln(
      '╔═══════════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ ❌ ERROR $tagStr');
    buffer.writeln(
      '╠═══════════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ $message');

    if (error != null) {
      buffer.writeln(
        '╠───────────────────────────────────────────────────────────────',
      );
      buffer.writeln('║ Details: ${error.toString()}');
    }

    if (LogConfig.enableDetailedErrors && stackTrace != null) {
      buffer.writeln(
        '╠───────────────────────────────────────────────────────────────',
      );
      buffer.writeln('║ Stack Trace:');
      final lines = stackTrace.toString().split('\n').take(5); // Chỉ 5 dòng đầu
      for (final line in lines) {
        buffer.writeln('║   $line');
      }
    }

    buffer.writeln(
      '╚═══════════════════════════════════════════════════════════════',
    );

    developer.log(buffer.toString(), name: _prefix, level: 1000);
  }

  // ═══════════════════════════════════════════════════════════════
  // HTTP LOGS (có thể tắt)
  // ═══════════════════════════════════════════════════════════════

  static void httpRequest(String method, String url, {dynamic data}) {
    if (!LogConfig.enableHttpLogs) return;

    final buffer = StringBuffer();
    final uri = Uri.parse(url);

    buffer.writeln('╔═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ 🚀 REQUEST: $method');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════');
    // Add domain 
    buffer.writeln('║ Domain: ${uri.host}');
    buffer.writeln('║ Endpoint: ${uri.path}');

    // Query parameters
    if (uri.queryParameters.isNotEmpty) {
      buffer.writeln('║ Query: ${uri.queryParameters}');
    }

    // Body
    if (data != null && ['POST', 'PUT', 'PATCH'].contains(method)) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📦 Body:');
      final bodyStr = _formatRequestBody(data);
      for (final line in bodyStr.split('\n')) {
        buffer.writeln('║   $line');
      }
    }

    buffer.writeln('╚═══════════════════════════════════════════════════════════════');
    developer.log(buffer.toString(), name: _prefix);
  }

  static void httpResponse(
    String method,
    String url,
    int statusCode, {
    dynamic data,
  }) {
    if (!LogConfig.enableHttpLogs || LogConfig.logOnlyFailedRequests) return;

    final buffer = StringBuffer();
    final uri = Uri.parse(url);
    final statusEmoji = statusCode >= 200 && statusCode < 300 ? '✅' : '⚠️';

    buffer.writeln('╔═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ $statusEmoji RESPONSE: $statusCode'); 
    buffer.writeln('╠═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ $method ${uri.path}');

    if (data != null) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📥 Response Data:');
      
      // Format data động theo response
      try {
        final encoder = JsonEncoder.withIndent('  ');
        final formatted = encoder.convert(data)
            .split('\n')
            .map((line) => '║   $line')
            .join('\n');
        buffer.writeln(formatted);
      } catch (e) {
        // Nếu không phải JSON thì hiển thị trực tiếp
        buffer.writeln('║   $data');
      }
    }

    buffer.writeln('╚═══════════════════════════════════════════════════════════════');
    developer.log(buffer.toString(), name: _prefix);
  }

  /// Log HTTP error - LUÔN hiển thị khi có lỗi
  static void httpError(
    String method,
    String url,
    int? statusCode,
    dynamic errorData,
  ) {
    final buffer = StringBuffer();

    buffer.writeln(
      '╔═══════════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ ❌ HTTP ERROR [$statusCode]');
    buffer.writeln(
      '╠═══════════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ $method $url');

    if (errorData != null) {
      buffer.writeln(
        '╠───────────────────────────────────────────────────────────────',
      );
      buffer.writeln('║ Response: ${_formatJson(errorData)}');
    }

    buffer.writeln(
      '╚═══════════════════════════════════════════════════════════════',
    );

    developer.log(buffer.toString(), name: _prefix, level: 900);
  }

  // ═══════════════════════════════════════════════════════════════
  // BLOC LOGS (có thể tắt)
  // ═══════════════════════════════════════════════════════════════

  /// Log Bloc event - tóm tắt
  static void blocEvent(String blocName, Object event) {
    if (!LogConfig.enableBlocLogs) return;
    developer.log('📤 [$blocName] ${event.runtimeType}', name: _prefix);
  }

  /// Log Bloc state change - chỉ log status thay đổi
  static void blocState(
    String blocName,
    dynamic currentState,
    dynamic nextState,
  ) {
    if (!LogConfig.enableBlocLogs) return;

    // Chỉ log khi status thay đổi (không log toàn bộ state)
    final current = _extractStatus(currentState);
    final next = _extractStatus(nextState);

    if (current != next) {
      developer.log('📥 [$blocName] $current → $next', name: _prefix);
    }
  }

  /// Log Bloc error - LUÔN hiển thị
  static void blocError(String blocName, Object error, StackTrace stackTrace) {
    final buffer = StringBuffer();

    buffer.writeln(
      '╔═══════════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ ❌ BLOC ERROR [$blocName]');
    buffer.writeln(
      '╠═══════════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ ${error.toString()}');

    if (LogConfig.enableDetailedErrors) {
      buffer.writeln(
        '╠───────────────────────────────────────────────────────────────',
      );
      final lines = stackTrace.toString().split('\n').take(3);
      for (final line in lines) {
        buffer.writeln('║ $line');
      }
    }

    buffer.writeln(
      '╚═══════════════════════════════════════════════════════════════',
    );

    developer.log(buffer.toString(), name: _prefix, level: 1000);
  }

  // ═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════

  static String _truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static String _formatJson(dynamic data) {
    if (data is Map) {
      final message = data['message'] ?? data['error'] ?? '';
      if (message.isNotEmpty) return message.toString();
    }
    return _truncate(data.toString(), 200);
  }

  /// Format request body cho dễ đọc
  static String _formatRequestBody(dynamic data) {
    if (data == null) return 'null';

    if (data is Map) {
      final buffer = StringBuffer();
      data.forEach((key, value) {
        // Ẩn sensitive data
        // if (_isSensitiveField(key.toString())) {
        //   buffer.writeln('$key: ******');
        // } else {
          buffer.writeln('$key: $value');
        // }
      });
      return buffer.toString().trim();
    }

    return _truncate(data.toString(), 300);
  }

  /// Kiểm tra field có phải sensitive không (password, token, etc.)
  // static bool _isSensitiveField(String fieldName) {
  //   final lowerField = fieldName.toLowerCase();
  //   return lowerField.contains('password') ||
  //       lowerField.contains('token') ||
  //       lowerField.contains('secret') ||
  //       lowerField.contains('apikey') ||
  //       lowerField.contains('authorization');
  // }

  static String _extractStatus(dynamic state) {
    if (state == null) return 'null';
    final str = state.toString();

    // Trích xuất status từ BaseState
    final statusMatch = RegExp(r'status:\s*BlocStatus\.(\w+)').firstMatch(str);
    if (statusMatch != null) {
      return statusMatch.group(1) ?? 'unknown';
    }

    return state.runtimeType.toString();
  }
}
