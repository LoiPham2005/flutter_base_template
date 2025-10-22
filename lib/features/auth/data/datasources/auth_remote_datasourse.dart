// import 'package:dio/dio.dart';
// import 'package:flutter_base_template/core/constants/api_constants.dart';
// import 'package:flutter_base_template/core/network/base_remote_data_source.dart';
// import 'package:flutter_base_template/core/network/dio_client.dart';
// import 'package:injectable/injectable.dart';
// import '../models/auth_model.dart';

// abstract class AuthRemoteDataSource {
//   Future<AuthResponseModel> login({
//     required String email,
//     required String password,
//   });
// }

// @LazySingleton(as: AuthRemoteDataSource)
// class AuthRemoteDataSourceImpl extends BaseRemoteDataSource
//     implements AuthRemoteDataSource {
//   final DioClient _dioClient;

//   AuthRemoteDataSourceImpl(this._dioClient);

//   @override
//   Future<AuthResponseModel> login({
//     required String email,
//     required String password,
//   }) async {
//     return safeApiCall(
//       () => _dioClient.post(
//         ApiConstants.login,
//         data: {'email': email, 'password': password},
//       ),
//       (data) => AuthResponseModel.fromJson(data),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_base_template/core/constants/api_constants.dart';
import 'package:flutter_base_template/core/errors/exceptions.dart';
import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/core/network/api_client.dart';
import 'package:flutter_base_template/core/network/base_remote_data_source.dart';
import 'package:flutter_base_template/core/network/dio_client.dart';
import 'package:injectable/injectable.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Result<AuthResponseModel>> login({
    required String email,
    required String password,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends BaseRemoteDataSource
    implements AuthRemoteDataSource {
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
      (json) => AuthResponseModel.fromJson(json['data'] ?? json),
      data: {'email': email, 'password': password},
    );
  }
}
