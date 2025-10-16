// import 'package:dio/dio.dart';
// import '../../../../core/network/dio_client.dart';
// import '../../../../core/constants/api_constants.dart';
// import '../../../../core/errors/exceptions.dart';
// import '../models/category_model.dart';

// abstract class CategoryRemoteDataSource {
//   Future<List<CategoryModel>> getCategories({Map<String, dynamic>? params});
//   Future<CategoryModel> getCategoryDetail(String id);
//   Future<CategoryModel> createCategory(Map<String, dynamic> data);
//   Future<CategoryModel> updateCategory(String id, Map<String, dynamic> data);
//   Future<bool> deleteCategory(String id);
// }

// class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
//   final DioClient dioClient;
  
//   CategoryRemoteDataSourceImpl(this.dioClient);
  
//   @override
//   Future<List<CategoryModel>> getCategories({Map<String, dynamic>? params}) async {
//     try {
//       final response = await dioClient.get(ApiConstants.categories, queryParameters: params);
//       final rawData = response.data['data'] ?? response.data;
//       if (rawData is! List) throw ServerException(message: 'Dữ liệu không hợp lệ');
//       return rawData.map((json) => CategoryModel.fromJson(json)).toList();
//     } on DioException catch (e) {
//       throw ServerException(
//         message: e.response?.data['message'] ?? 'Không thể tải danh mục',
//       );
//     } catch (_) {
//       throw ServerException(message: 'Lỗi không xác định khi tải danh mục');
//     }
//   }
  
//   @override
//   Future<CategoryModel> getCategoryDetail(String id) async {
//     try {
//       final response = await dioClient.get('${ApiConstants.categories}/$id');
//       return CategoryModel.fromJson(response.data['data'] ?? response.data);
//     } catch (e) {
//       throw ServerException(message: 'Không thể tải chi tiết danh mục');
//     }
//   }
  
//   @override
//   Future<CategoryModel> createCategory(Map<String, dynamic> data) async {
//     try {
//       final response = await dioClient.post(ApiConstants.categories, data: data);
//       return CategoryModel.fromJson(response.data['data'] ?? response.data);
//     } catch (e) {
//       throw ServerException(message: 'Không thể tạo danh mục');
//     }
//   }
  
//   @override
//   Future<CategoryModel> updateCategory(String id, Map<String, dynamic> data) async {
//     try {
//       final response = await dioClient.put('${ApiConstants.categories}/$id', data: data);
//       return CategoryModel.fromJson(response.data['data'] ?? response.data);
//     } catch (e) {
//       throw ServerException(message: 'Không thể cập nhật danh mục');
//     }
//   }
  
//   @override
//   Future<bool> deleteCategory(String id) async {
//     try {
//       await dioClient.delete('${ApiConstants.categories}/$id');
//       return true;
//     } catch (e) {
//       throw ServerException(message: 'Không thể xóa danh mục');
//     }
//   }
// }


import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({Map<String, dynamic>? params});
  Future<CategoryModel> getCategoryDetail(String id);
  Future<CategoryModel> createCategory(Map<String, dynamic> data);
  Future<CategoryModel> updateCategory(String id, Map<String, dynamic> data);
  Future<bool> deleteCategory(String id);
}

@LazySingleton()
class CategoryRemoteDataSourceImpl extends BaseRemoteDataSource
    implements CategoryRemoteDataSource {
  final DioClient dioClient;

  CategoryRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<CategoryModel>> getCategories({Map<String, dynamic>? params}) {
    return safeApiCall(
      () => dioClient.get(ApiConstants.categories, queryParameters: params),
      (data) {
        if (data is! List) {
          throw ServerException(message: 'Dữ liệu không hợp lệ');
        }
        return data.map((e) => CategoryModel.fromJson(e)).toList();
      },
      errorMessage: 'Không thể tải danh mục',
    );
  }

  @override
  Future<CategoryModel> getCategoryDetail(String id) {
    return safeApiCall(
      () => dioClient.get('${ApiConstants.categories}/$id'),
      (data) => CategoryModel.fromJson(data),
      errorMessage: 'Không thể tải chi tiết danh mục',
    );
  }

  @override
  Future<CategoryModel> createCategory(Map<String, dynamic> data) {
    return safeApiCall(
      () => dioClient.post(ApiConstants.categories, data: data),
      (data) => CategoryModel.fromJson(data),
      errorMessage: 'Không thể tạo danh mục',
    );
  }

  @override
  Future<CategoryModel> updateCategory(String id, Map<String, dynamic> data) {
    return safeApiCall(
      () => dioClient.put('${ApiConstants.categories}/$id', data: data),
      (data) => CategoryModel.fromJson(data),
      errorMessage: 'Không thể cập nhật danh mục',
    );
  }

  @override
  Future<bool> deleteCategory(String id) {
    return safeApiCall(
      () => dioClient.delete('${ApiConstants.categories}/$id'),
      (_) => true,
      errorMessage: 'Không thể xóa danh mục',
    );
  }
}
