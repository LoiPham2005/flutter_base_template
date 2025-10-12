// lib/core/network/api_client.dart
import '../errors/exceptions.dart';
import '../errors/result.dart';
import '../errors/failures.dart';
import 'dio_client.dart';

class ApiClient {
  final DioClient _dioClient;
  
  ApiClient(this._dioClient);
  
  // Safe GET request with Result pattern
  Future<Result<T>> getResult<T>(
    String path,
    T Function(dynamic) fromJson, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.get(
        path,
        queryParameters: queryParameters,
      );
      
      final data = fromJson(response.data);
      return Success(data);
    } on AppException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }
  
  // Safe POST request with Result pattern
  Future<Result<T>> postResult<T>(
    String path,
    T Function(dynamic) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      
      final result = fromJson(response.data);
      return Success(result);
    } on AppException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }
  
  // Safe PUT request with Result pattern
  Future<Result<T>> putResult<T>(
    String path,
    T Function(dynamic) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      
      final result = fromJson(response.data);
      return Success(result);
    } on AppException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }
  
  // Safe DELETE request with Result pattern
  Future<Result<bool>> deleteResult(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _dioClient.delete(
        path,
        queryParameters: queryParameters,
      );
      
      return const Success(true);
    } on AppException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }
}