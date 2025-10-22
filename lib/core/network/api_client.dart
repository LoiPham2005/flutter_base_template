// // lib/core/network/api_client.dart
// import 'package:injectable/injectable.dart';

// import '../errors/exceptions.dart';
// import '../errors/result.dart';
// import '../errors/failures.dart';
// import 'dio_client.dart';


// typedef JsonParser<T> = T Function(dynamic json);

// @LazySingleton()
// class ApiClient {
  
//   ApiClient(this._dioClient);
  
//   final DioClient _dioClient;
  
//   // Safe GET request with Result pattern
//   Future<Result<T>> getResult<T>(
//     String path,
//     // T Function(dynamic) fromJson, 
//     JsonParser<T> fromJson,
//     {
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       final response = await _dioClient.get(
//         path,
//         queryParameters: queryParameters,
//       );
      
//       final data = fromJson(response.data);
//       return Success(data);
//     } on AppException catch (e) {
//       return Error(ServerFailure(message: e.message, code: e.code));
//     } catch (e) {
//       return Error(UnknownFailure(message: e.toString()));
//     }
//   }
  
//   // Safe POST request with Result pattern
//   Future<Result<T>> postResult<T>(
//     String path,
//     T Function(dynamic) fromJson, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       final response = await _dioClient.post(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
      
//       final result = fromJson(response.data);
//       return Success(result);
//     } on AppException catch (e) {
//       return Error(ServerFailure(message: e.message, code: e.code));
//     } catch (e) {
//       return Error(UnknownFailure(message: e.toString()));
//     }
//   }
  
//   // Safe PUT request with Result pattern
//   Future<Result<T>> putResult<T>(
//     String path,
//     T Function(dynamic) fromJson, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       final response = await _dioClient.put(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
      
//       final result = fromJson(response.data);
//       return Success(result);
//     } on AppException catch (e) {
//       return Error(ServerFailure(message: e.message, code: e.code));
//     } catch (e) {
//       return Error(UnknownFailure(message: e.toString()));
//     }
//   }
  
//   // Safe DELETE request with Result pattern
//   Future<Result<bool>> deleteResult(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       await _dioClient.delete(
//         path,
//         queryParameters: queryParameters,
//       );
      
//       return const Success(true);
//     } on AppException catch (e) {
//       return Error(ServerFailure(message: e.message, code: e.code));
//     } catch (e) {
//       return Error(UnknownFailure(message: e.toString()));
//     }
//   }
// }




// lib/core/network/api_client.dart
import 'package:injectable/injectable.dart';
import '../errors/exceptions.dart';
import '../errors/result.dart';
import '../errors/failures.dart';
import 'dio_client.dart';

typedef JsonParser<T> = T Function(dynamic json);

@LazySingleton()
class ApiClient {
  ApiClient(this._dioClient);

  final DioClient _dioClient;

  /// Helper để lấy ra phần data trong response
  dynamic _unwrapResponse(dynamic json) {
    if (json is Map<String, dynamic> && json.containsKey('data')) {
      return json['data'];
    }
    return json;
  }

  // --------------------- GET ---------------------
  Future<Result<T>> getResult<T>(
    String path,
    JsonParser<T> fromJson, {
    Map<String, dynamic>? queryParameters,
    bool unwrap = true, // <== mặc định true
  }) async {
    try {
      final response = await _dioClient.get(
        path,
        queryParameters: queryParameters,
      );

      final parsedJson = unwrap ? _unwrapResponse(response.data) : response.data;
      final data = fromJson(parsedJson);

      return Success(data);
    } on AppException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }

  // --------------------- POST ---------------------
  Future<Result<T>> postResult<T>(
    String path,
    JsonParser<T> fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool unwrap = true,
  }) async {
    try {
      final response = await _dioClient.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      final parsedJson = unwrap ? _unwrapResponse(response.data) : response.data;
      final result = fromJson(parsedJson);

      return Success(result);
    } on AppException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }

  // --------------------- PUT ---------------------
  Future<Result<T>> putResult<T>(
    String path,
    JsonParser<T> fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool unwrap = true,
  }) async {
    try {
      final response = await _dioClient.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      final parsedJson = unwrap ? _unwrapResponse(response.data) : response.data;
      final result = fromJson(parsedJson);

      return Success(result);
    } on AppException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }

  // --------------------- DELETE ---------------------
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
