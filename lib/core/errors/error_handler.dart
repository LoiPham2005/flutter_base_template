// lib/core/errors/error_handler.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  ErrorHandler._();
  
  // Convert Exception to Failure
  static Failure handleException(Object exception) {
    if (exception is ServerException) {
      return ServerFailure(message: exception.message, code: exception.code);
    } else if (exception is NetworkException) {
      return NetworkFailure(message: exception.message, code: exception.code);
    } else if (exception is CacheException) {
      return CacheFailure(message: exception.message, code: exception.code);
    } else if (exception is AuthenticationException) {
      return AuthenticationFailure(message: exception.message, code: exception.code);
    } else if (exception is UnauthorizedException) {
      return UnauthorizedFailure(message: exception.message, code: exception.code);
    } else if (exception is NotFoundException) {
      return NotFoundFailure(message: exception.message, code: exception.code);
    } else if (exception is ValidationException) {
      return ValidationFailure(
        message: exception.message,
        code: exception.code,
        errors: exception.errors,
      );
    } else if (exception is TimeoutException) {
      return TimeoutFailure(message: exception.message, code: exception.code);
    } else {
      return UnknownFailure(message: exception.toString());
    }
  }
  
  // Handle Dio Error
  static AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: 'Hết thời gian chờ kết nối');
      
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode, error.response?.data);
      
      case DioExceptionType.cancel:
        return AppException(message: 'Yêu cầu đã bị hủy');
      
      case DioExceptionType.connectionError:
        return NetworkException(message: 'Không có kết nối mạng');
      
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NetworkException(message: 'Không có kết nối mạng');
        }
        return AppException(message: 'Đã xảy ra lỗi không xác định');
      
      default:
        return AppException(message: 'Đã xảy ra lỗi không xác định');
    }
  }
  
  static AppException _handleStatusCode(int? statusCode, dynamic data) {
    String message = 'Đã xảy ra lỗi';
    
    // Try to extract message from response
    if (data is Map<String, dynamic>) {
      message = data['message'] ?? data['error'] ?? message;
    }
    
    switch (statusCode) {
      case 400:
        return ValidationException(
          message: message,
          code: '400',
          errors: _extractErrors(data),
        );
      
      case 401:
        return AuthenticationException(
          message: 'Phiên đăng nhập hết hạn',
          code: '401',
        );
      
      case 403:
        return UnauthorizedException(
          message: 'Bạn không có quyền truy cập',
          code: '403',
        );
      
      case 404:
        return NotFoundException(
          message: 'Không tìm thấy dữ liệu',
          code: '404',
        );
      
      case 422:
        return ValidationException(
          message: message,
          code: '422',
          errors: _extractErrors(data),
        );
      
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: 'Lỗi máy chủ, vui lòng thử lại sau',
          code: statusCode.toString(),
        );
      
      default:
        return ServerException(
          message: message,
          code: statusCode?.toString(),
        );
    }
  }
  
  static Map<String, String>? _extractErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        return errors.map(
          (key, value) => MapEntry(
            key,
            value is List ? value.first.toString() : value.toString(),
          ),
        );
      }
    }
    return null;
  }
  
  // Log error
  static void logError(Object error, [StackTrace? stackTrace]) {
    print('❌ ERROR: $error');
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
  }
}