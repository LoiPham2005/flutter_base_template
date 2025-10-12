// lib/core/errors/exceptions.dart

// Base Exception
class AppException implements Exception {
  final String message;
  final String? code;
  
  AppException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

// Server Exception
class ServerException extends AppException {
  ServerException({
    required super.message,
    super.code,
  });
}

// Network Exception
class NetworkException extends AppException {
  NetworkException({
    String message = 'Lỗi kết nối mạng',
    super.code,
  }) : super(message: message);
}

// Cache Exception
class CacheException extends AppException {
  CacheException({
    String message = 'Lỗi cache',
    super.code,
  }) : super(message: message);
}

// Authentication Exception
class AuthenticationException extends AppException {
  AuthenticationException({
    String message = 'Lỗi xác thực',
    super.code,
  }) : super(message: message);
}

// Unauthorized Exception
class UnauthorizedException extends AppException {
  UnauthorizedException({
    String message = 'Không có quyền truy cập',
    super.code,
  }) : super(message: message);
}

// Not Found Exception
class NotFoundException extends AppException {
  NotFoundException({
    String message = 'Không tìm thấy dữ liệu',
    super.code,
  }) : super(message: message);
}

// Validation Exception
class ValidationException extends AppException {
  final Map<String, String>? errors;
  
  ValidationException({
    String message = 'Dữ liệu không hợp lệ',
    super.code,
    this.errors,
  }) : super(message: message);
}

// Timeout Exception
class TimeoutException extends AppException {
  TimeoutException({
    String message = 'Hết thời gian chờ',
    super.code,
  }) : super(message: message);
}