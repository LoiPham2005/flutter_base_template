// lib/core/network/api_client.dart
import 'package:flutter_base_template/core/network/api_response.dart';
import 'package:injectable/injectable.dart';
import '../errors/exceptions.dart';
import '../errors/result.dart';
import '../errors/failures.dart';
import 'dio_client.dart';
import '../network/network_info.dart';

typedef JsonParser<T> = T Function(dynamic json);

@LazySingleton()
class ApiClient {
  ApiClient(this._dioClient, this._networkInfo);
  final DioClient _dioClient;
  final NetworkInfo _networkInfo;

  // ===============================
  // Helper: Unwrap API Response
  // ===============================
  T _unwrapApiResponse<T>(dynamic responseData, JsonParser<T> fromJson) {
    if (responseData is! Map<String, dynamic>) {
      return fromJson(responseData);
    }

    final apiResponse = ApiResponse<T>.fromJson(responseData, (json) {
      return json == null ? fromJson(responseData) : fromJson(json);
    });

    if (apiResponse.isSuccess) {
      return apiResponse.data ?? fromJson(responseData);
    } else {
      throw ServerException(
        message: apiResponse.error ?? apiResponse.message ?? 'Request failed',
        code: apiResponse.code?.toString(),
      );
    }
  }

  // ===============================
  // Safe + Retry
  // ===============================
  Future<Result<T>> _safeRequest<T>(
    Future<Result<T>> Function() request,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Error(NetworkFailure());
    }
    return request();
  }

  Future<Result<T>> _retryRequest<T>(
    Future<Result<T>> Function() request, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempt = 0;
    while (true) {
      try {
        return await request();
      } catch (e) {
        attempt++;
        if (attempt >= maxRetries) {
          return Error(UnknownFailure(message: 'Max retries exceeded: $e'));
        }
        await Future.delayed(delay * attempt);
      }
    }
  }

  // ===============================
  // GET
  // ===============================
  Future<Result<T>> getResult<T>(
    String path,
    JsonParser<T> fromJson, {
    Map<String, dynamic>? queryParameters,
    int maxRetries = 1,
    bool unwrap = true, // Thêm option unwrap
  }) async {
    return _safeRequest(
      () => _retryRequest(() async {
        final response = await _dioClient.get(
          path,
          queryParameters: queryParameters,
        );
        final data = unwrap
            ? _unwrapApiResponse<T>(response.data, fromJson)
            : fromJson(response.data);
        return Success(data);
      }, maxRetries: maxRetries),
    );
  }

  // ===============================
  // POST
  // ===============================
  Future<Result<T>> postResult<T>(
    String path,
    JsonParser<T> fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    int maxRetries = 1,
    bool unwrap = true, // Thêm option unwrap
  }) async {
    return _safeRequest(
      () => _retryRequest(() async {
        final response = await _dioClient.post(
          path,
          data: data,
          queryParameters: queryParameters,
        );
        final result = unwrap
            ? _unwrapApiResponse<T>(response.data, fromJson)
            : fromJson(response.data);
        return Success(result);
      }, maxRetries: maxRetries),
    );
  }

  // ===============================
  // PATCH
  // ===============================
  Future<Result<T>> patchResult<T>(
    String path,
    JsonParser<T> fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    int maxRetries = 1,
    bool unwrap = true, // Thêm option unwrap
  }) async {
    return _safeRequest(
      () => _retryRequest(() async {
        final response = await _dioClient.patch(
          path,
          data: data,
          queryParameters: queryParameters,
        );
        final result = unwrap
            ? _unwrapApiResponse<T>(response.data, fromJson)
            : fromJson(response.data);
        return Success(result);
      }, maxRetries: maxRetries),
    );
  }

  // ===============================
  // PUT
  // ===============================
  Future<Result<T>> putResult<T>(
    String path,
    JsonParser<T> fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    int maxRetries = 1,
    bool unwrap = true, // Thêm option unwrap
  }) async {
    return _safeRequest(
      () => _retryRequest(() async {
        final response = await _dioClient.put(
          path,
          data: data,
          queryParameters: queryParameters,
        );
        final result = unwrap
            ? _unwrapApiResponse<T>(response.data, fromJson)
            : fromJson(response.data);
        return Success(result);
      }, maxRetries: maxRetries),
    );
  }

  // ===============================
  // DELETE
  // ===============================
  Future<Result<bool>> deleteResult(
    String path, {
    Map<String, dynamic>? queryParameters,
    int maxRetries = 1,
  }) async {
    return _safeRequest(
      () => _retryRequest(() async {
        final response = await _dioClient.delete(
          path,
          queryParameters: queryParameters,
        );

        if (response.data is Map<String, dynamic>) {
          final success =
              response.data['success'] ?? response.data['result'] ?? true;
          if (!success) {
            throw ServerException(
              message: response.data['message'] ?? 'Delete failed',
            );
          }
        }

        return const Success(true);
      }, maxRetries: maxRetries),
    );
  }
  
}
