// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';

// Base Failure
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  
  const Failure({
    required this.message,
    this.code,
  });
  
  @override
  List<Object?> get props => [message, code];
  
  @override
  String toString() => message;
}

// Server Failure
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

// Network Failure
class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'Không có kết nối mạng',
    super.code,
  }) : super(message: message);
}

// Cache Failure
class CacheFailure extends Failure {
  const CacheFailure({
    String message = 'Lỗi lưu trữ dữ liệu',
    super.code,
  }) : super(message: message);
}

// Authentication Failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    String message = 'Xác thực thất bại',
    super.code,
  }) : super(message: message);
}

// Unauthorized Failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    String message = 'Bạn không có quyền truy cập',
    super.code,
  }) : super(message: message);
}

// Not Found Failure
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    String message = 'Không tìm thấy dữ liệu',
    super.code,
  }) : super(message: message);
}

// Validation Failure
class ValidationFailure extends Failure {
  final Map<String, String>? errors;
  
  const ValidationFailure({
    String message = 'Dữ liệu không hợp lệ',
    super.code,
    this.errors,
  }) : super(message: message);
  
  @override
  List<Object?> get props => [message, code, errors];
}

// Timeout Failure
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    String message = 'Hết thời gian chờ',
    super.code,
  }) : super(message: message);
}

// Unknown Failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'Đã xảy ra lỗi không xác định',
    super.code,
  }) : super(message: message);
}
