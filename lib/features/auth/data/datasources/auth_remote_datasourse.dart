import 'package:flutter_base_template/core/constants/api_constants.dart';
import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/core/network/api_client.dart';
import 'package:injectable/injectable.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Result<AuthResponseModel>> login({
    required String email,
    required String password,
  });
  Future<Result<bool>> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<Result<AuthResponseModel>> login({
    required String email,
    required String password,
  }) async {
    // Trả về Result nguyên vẹn, không fold
    return _apiClient.postResult(
      ApiConstants.login,
      (json) => AuthResponseModel.fromJson(json),
      data: {'email': email, 'password': password},
    );
  }

  @override
  Future<Result<bool>> logout() async {
    return _apiClient.postResult(
      ApiConstants.logout,
      (json) => true,
    );
  }
}
