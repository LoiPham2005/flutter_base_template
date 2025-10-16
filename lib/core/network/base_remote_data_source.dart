import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

/// ✅ Lớp cơ sở cho tất cả RemoteDataSource
abstract class BaseRemoteDataSource {
  /// Hàm thực thi API call an toàn, dùng chung cho tất cả datasource
  Future<T> safeApiCall<T>(
    Future<Response> Function() apiCall,
    T Function(dynamic data) parser, {
    String? errorMessage,
  }) async {
    try {
      final response = await apiCall();

      // Nếu response có trường "data" thì lấy ra, không thì lấy luôn response.data
      final data = response.data['data'] ?? response.data;

      // Dùng parser để convert sang model hoặc list model
      return parser(data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ??
            errorMessage ??
            'Lỗi kết nối đến máy chủ',
      );
    } catch (e) {
      throw ServerException(
        message: errorMessage ?? 'Đã xảy ra lỗi không xác định: ${e.toString()}',
      );
    }
  }
}
