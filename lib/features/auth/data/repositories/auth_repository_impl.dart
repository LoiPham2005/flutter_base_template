import 'package:flutter_base_template/core/errors/exceptions.dart';
import 'package:flutter_base_template/core/errors/failures.dart';
import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/core/network/base_repository.dart';
import 'package:flutter_base_template/core/network/network_info.dart';
import 'package:flutter_base_template/features/auth/data/datasources/auth_remote_datasourse.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._networkInfo)
    : super(_networkInfo);
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );

     return result.map((model) => model.toEntity());
    });
  }
}
