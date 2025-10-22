import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/features/auth/data/datasources/auth_remote_datasourse.dart';
import 'package:flutter_base_template/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_base_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    // Gọi thẳng remoteDataSource, map model → entity
    final result = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    return result.map((model) => model.toEntity());
  }
}
