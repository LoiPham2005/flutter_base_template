import 'package:flutter_base_template/core/errors/result.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<Result<bool>> logout(); // Thêm method logout
}
