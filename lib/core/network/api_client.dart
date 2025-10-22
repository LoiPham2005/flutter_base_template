// lib/core/network/api_client.dart
import 'package:injectable/injectable.dart';
import '../errors/exceptions.dart';
import '../errors/result.dart';
import '../errors/failures.dart';
import 'dio_client.dart';
import 'api_response.dart';
import '../network/network_info.dart';

typedef JsonParser<T> = T Function(dynamic json);

@LazySingleton()
class ApiClient {
  // Thêm NetworkInfo

  ApiClient(this._dioClient, this._networkInfo);
  final DioClient _dioClient;
  final NetworkInfo _networkInfo;

  // ========================================
  // ✅ HELPER: Unwrap API Response
  // ========================================

  /// Xử lý response có cấu trúc {success, message, data}
  T _unwrapApiResponse<T>(dynamic responseData, JsonParser<T> fromJson) {
    // Case 1: Response là ApiResponse wrapper
    if (responseData is Map<String, dynamic>) {
      // Kiểm tra có key "success" hoặc "result"
      final hasSuccess = responseData.containsKey('success');
      final hasResult = responseData.containsKey('result');

      if (hasSuccess || hasResult) {
        // Lấy success flag
        final success =
            responseData['success'] ?? responseData['result'] ?? false;
        final message = responseData['message'] as String?;
        final data = responseData['data'];
        final error = responseData['error'] as String?;
        final code = responseData['code'] as int?;

        // ✅ Check success
        if (success) {
          // Success case
          if (data == null) {
            // Không có data, trả về response gốc
            return fromJson(responseData);
          } else {
            // Có data, parse data
            return fromJson(data);
          }
        } else {
          // ❌ API trả về success = false
          throw ServerException(
            message: error ?? message ?? 'Request failed',
            code: code?.toString(),
          );
        }
      }
    }

    // Case 2: Response trực tiếp là data (không có wrapper)
    return fromJson(responseData);
  }

  /// Check network và wrap Result
  Future<Result<T>> _safeRequest<T>(
    Future<Result<T>> Function() request,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Error(NetworkFailure());
    }
    return request();
  }

  // ========================================
  // GET REQUEST
  // ========================================
  Future<Result<T>> getResult<T>(
    String path,
    JsonParser<T> fromJson, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(() async {
      try {
        final response = await _dioClient.get(
          path,
          queryParameters: queryParameters,
        );

        // ✅ Unwrap response
        final data = _unwrapApiResponse<T>(response.data, fromJson);
        return Success(data);
      } on AppException catch (e) {
        return Error(ServerFailure(message: e.message));
      } catch (e) {
        return Error(UnknownFailure(message: e.toString()));
      }
    });
  }

  // ========================================
  // POST REQUEST
  // ========================================
  Future<Result<T>> postResult<T>(
    String path,
    JsonParser<T> fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(() async {
      try {
        final response = await _dioClient.post(
          path,
          data: data,
          queryParameters: queryParameters,
        );

        // ✅ Unwrap response
        final result = _unwrapApiResponse<T>(response.data, fromJson);
        return Success(result);
      } on AppException catch (e) {
        return Error(ServerFailure(message: e.message, code: e.code));
      } catch (e) {
        return Error(UnknownFailure(message: e.toString()));
      }
    });
  }

  // ========================================
  // PUT REQUEST
  // ========================================
  Future<Result<T>> putResult<T>(
    String path,
    JsonParser<T> fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(() async {
      try {
        final response = await _dioClient.put(
          path,
          data: data,
          queryParameters: queryParameters,
        );

        // ✅ Unwrap response
        final result = _unwrapApiResponse<T>(response.data, fromJson);
        return Success(result);
      } on AppException catch (e) {
        return Error(ServerFailure(message: e.message, code: e.code));
      } catch (e) {
        return Error(UnknownFailure(message: e.toString()));
      }
    });
  }

  // ========================================
  // DELETE REQUEST
  // ========================================
  Future<Result<bool>> deleteResult(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(() async {
      try {
        final response = await _dioClient.delete(
          path,
          queryParameters: queryParameters,
        );

        // Check success trong response
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
      } on AppException catch (e) {
        return Error(ServerFailure(message: e.message, code: e.code));
      } catch (e) {
        return Error(UnknownFailure(message: e.toString()));
      }
    });
  }

  // ========================================
  // ✅ BONUS: GET LIST (với pagination)
  // ========================================
  Future<Result<List<T>>> getListResult<T>(
    String path,
    JsonParser<T> fromJson, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(() async {
      try {
        final response = await _dioClient.get(
          path,
          queryParameters: queryParameters,
        );

        // Unwrap và parse list
        final data = _unwrapApiResponse<List<dynamic>>(response.data, (json) {
          if (json is List) {
            return json;
          } else if (json is Map && json.containsKey('items')) {
            return json['items'] as List;
          } else if (json is Map && json.containsKey('list')) {
            return json['list'] as List;
          }
          throw Exception('Invalid list response format');
        });

        // Convert to typed list
        final list = data.map((item) => fromJson(item)).toList();
        return Success(list);
      } on AppException catch (e) {
        return Error(ServerFailure(message: e.message, code: e.code));
      } catch (e) {
        return Error(UnknownFailure(message: e.toString()));
      }
    });
  }
}
