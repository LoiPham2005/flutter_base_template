import 'package:dio/dio.dart';
import 'package:flutter_base_template/core/network/repository_helper/base_response.dart';

class ApiHelper {
  /// Gọi API và xử lý kết quả trả về là **một đối tượng**
  ///
  /// [apiCall]: Hàm gọi API trả về Future<Response>, ví dụ: `() => dio.get('/user/1')`
  /// [fromJson]: Hàm chuyển đổi Map<String, dynamic> sang đối tượng T, ví dụ: `(json) => User.fromJson(json)`
  static Future<BaseResponse<T>> handleRequest<T>({
    required Future<Response> Function() apiCall,
    required T Function(Map<String, dynamic>) fromJson,
    String dataKey = 'data',
    dynamic Function(Map<String, dynamic> map)? extract,
  }) async {
    try {
      final response = await apiCall();
      return BaseResponse.fromResponse(
        response,
        fromJson,
        dataKey: dataKey,
        extract: extract,
      );
    } catch (e) {
      return BaseResponse.handleError<T>(e);
    }
  }

  /// Gọi API và xử lý kết quả trả về là **một danh sách đối tượng**
  ///
  /// [apiCall]: Hàm gọi API trả về Future<Response>, ví dụ: `() => dio.get('/users')`
  /// [fromJson]: Hàm chuyển đổi từng phần tử trong danh sách json sang đối tượng T, ví dụ: `(json) => User.fromJson(json)`
  static Future<BaseResponse<List<T>>> handleListRequest<T>({
    required Future<Response> Function() apiCall,
    required T Function(Map<String, dynamic>) fromJson,
    String dataKey = 'data',
    dynamic Function(Map<String, dynamic> map)? extract,
  }) async {
    try {
      final response = await apiCall();
      return BaseResponse.listFromResponse(
        response,
        fromJson,
        dataKey: dataKey,
        extract: extract,
      );
    } catch (e) {
      return BaseResponse.handleError(e);
    }
  }
}
