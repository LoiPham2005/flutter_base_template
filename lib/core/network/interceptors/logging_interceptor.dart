// lib/core/network/interceptors/logging_interceptor.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../utils/logger.dart';

@LazySingleton()
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final uri = options.uri;
    final method = options.method;
    
    Logger.debug(
      _buildRequestLog(method, uri, options),
      tag: 'HTTP',
    );
    
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final method = response.requestOptions.method;
    final uri = response.requestOptions.uri;
    
    Logger.info(
      _buildResponseLog(method, uri, statusCode, response),
      tag: 'HTTP',
    );
    
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final method = err.requestOptions.method;
    final uri = err.requestOptions.uri;
    
    Logger.error(
      _buildErrorLog(method, uri, statusCode, err),
      tag: 'HTTP',
    );
    
    handler.next(err);
  }

  // ════════════════════════════════════════════════════════════════
  // 🎨 REQUEST LOG BUILDER
  // ════════════════════════════════════════════════════════════════
  String _buildRequestLog(String method, Uri uri, RequestOptions options) {
    final buffer = StringBuffer();
    
    buffer.writeln('');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ 🚀 REQUEST');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ Method    : $method');
    buffer.writeln('║ URL       : ${uri.toString()}');
    
    // Query Parameters
    if (options.queryParameters.isNotEmpty) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 🔍 Query Parameters:');
      options.queryParameters.forEach((key, value) {
        buffer.writeln('║   • $key: $value');
      });
    }
    
    // Headers
    if (options.headers.isNotEmpty) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📋 Headers:');
      options.headers.forEach((key, value) {
        // Che token cho bảo mật
        if (key.toLowerCase() == 'authorization') {
          buffer.writeln('║   • $key: ${_maskToken(value.toString())}');
        } else {
          buffer.writeln('║   • $key: $value');
        }
      });
    }
    
    // Request Body
    if (options.data != null) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📦 Body:');
      buffer.writeln('║');
      _formatData(options.data).split('\n').forEach((line) {
        buffer.writeln('║   $line');
      });
    }
    
    buffer.writeln('╚═══════════════════════════════════════════════════════════════');
    
    return buffer.toString();
  }

  // ════════════════════════════════════════════════════════════════
  // 🎨 RESPONSE LOG BUILDER
  // ════════════════════════════════════════════════════════════════
  String _buildResponseLog(
    String method,
    Uri uri,
    int? statusCode,
    Response response,
  ) {
    final buffer = StringBuffer();
    final statusEmoji = _getStatusEmoji(statusCode);
    
    buffer.writeln('');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ $statusEmoji RESPONSE [$statusCode]');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ Method    : $method');
    buffer.writeln('║ URL       : ${uri.toString()}');
    buffer.writeln('║ Status    : $statusCode ${_getStatusText(statusCode)}');
    
    // Response Headers
    if (response.headers.map.isNotEmpty) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📋 Response Headers:');
      response.headers.map.forEach((key, values) {
        buffer.writeln('║   • $key: ${values.join(', ')}');
      });
    }
    
    // Response Data
    if (response.data != null) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📥 Response Data:');
      buffer.writeln('║');
      _formatData(response.data).split('\n').forEach((line) {
        buffer.writeln('║   $line');
      });
    }
    
    buffer.writeln('╚═══════════════════════════════════════════════════════════════');
    
    return buffer.toString();
  }

  // ════════════════════════════════════════════════════════════════
  // 🎨 ERROR LOG BUILDER
  // ════════════════════════════════════════════════════════════════
  String _buildErrorLog(
    String method,
    Uri uri,
    int? statusCode,
    DioException err,
  ) {
    final buffer = StringBuffer();
    
    buffer.writeln('');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ ❌ ERROR ${statusCode != null ? '[$statusCode]' : ''}');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════');
    buffer.writeln('║ Method    : $method');
    buffer.writeln('║ URL       : ${uri.toString()}');
    buffer.writeln('║ Type      : ${err.type.name}');
    buffer.writeln('║ Message   : ${err.message ?? 'No message'}');
    
    if (statusCode != null) {
      buffer.writeln('║ Status    : $statusCode ${_getStatusText(statusCode)}');
    }
    
    // Error Response Data
    if (err.response?.data != null) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📥 Error Response:');
      buffer.writeln('║');
      _formatData(err.response!.data).split('\n').forEach((line) {
        buffer.writeln('║   $line');
      });
    }
    
    // Stack Trace (nếu có)
    if (err.stackTrace != null) {
      buffer.writeln('╠───────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📚 Stack Trace:');
      buffer.writeln('║');
      final stackLines = err.stackTrace.toString().split('\n').take(5);
      for (final line in stackLines) {
        buffer.writeln('║   $line');
      }
    }
    
    buffer.writeln('╚═══════════════════════════════════════════════════════════════');
    
    return buffer.toString();
  }

  // ════════════════════════════════════════════════════════════════
  // 🛠️ HELPER FUNCTIONS
  // ════════════════════════════════════════════════════════════════
  
  /// Format JSON data với indent đẹp
  String _formatData(dynamic data) {
    try {
      if (data is Map || data is List) {
        const encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(data);
      }
      return data.toString();
    } catch (e) {
      return data.toString();
    }
  }

  /// Che token bảo mật (chỉ hiện 10 ký tự đầu và cuối)
  String _maskToken(String token) {
    if (token.length <= 20) return '***';
    return '${token.substring(0, 10)}...${token.substring(token.length - 10)}';
  }

  /// Lấy emoji theo status code
  String _getStatusEmoji(int? statusCode) {
    if (statusCode == null) return '❓';
    if (statusCode >= 200 && statusCode < 300) return '✅';
    if (statusCode >= 300 && statusCode < 400) return '↪️';
    if (statusCode >= 400 && statusCode < 500) return '⚠️';
    if (statusCode >= 500) return '🔥';
    return '❓';
  }

  /// Lấy text mô tả status code
  String _getStatusText(int? statusCode) {
    if (statusCode == null) return '';
    
    final statusTexts = {
      200: 'OK',
      201: 'Created',
      204: 'No Content',
      400: 'Bad Request',
      401: 'Unauthorized',
      403: 'Forbidden',
      404: 'Not Found',
      422: 'Unprocessable Entity',
      500: 'Internal Server Error',
      502: 'Bad Gateway',
      503: 'Service Unavailable',
    };
    
    return statusTexts[statusCode] ?? '';
  }
}