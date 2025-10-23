// lib/core/errors/exceptions.dart

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
    super.message = 'Lỗi kết nối mạng',
    super.code,
  });
}

// Cache Exception
class CacheException extends AppException {
  CacheException({
    super.message = 'Lỗi cache',
    super.code,
  });
}

// Authentication Exception
class AuthenticationException extends AppException {
  AuthenticationException({
    super.message = 'Lỗi xác thực',
    super.code,
  });
}

// Unauthorized Exception
class UnauthorizedException extends AppException {
  UnauthorizedException({
    super.message = 'Không có quyền truy cập',
    super.code,
  });
}

// Not Found Exception
class NotFoundException extends AppException {
  NotFoundException({
    super.message = 'Không tìm thấy dữ liệu',
    super.code,
  });
}

// Validation Exception
class ValidationException extends AppException {
  final Map<String, String>? errors;
  
  ValidationException({
    super.message = 'Dữ liệu không hợp lệ',
    super.code,
    this.errors,
  });
}

// Timeout Exception
class TimeoutException extends AppException {
  TimeoutException({
    super.message = 'Hết thời gian chờ',
    super.code,
  });
}