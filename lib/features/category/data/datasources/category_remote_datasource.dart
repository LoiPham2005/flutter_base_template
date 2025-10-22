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

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/core/network/api_client.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<Result<List<CategoryModel>>> getCategories({
    Map<String, dynamic>? params,
  });
  Future<Result<CategoryModel>> getCategoryDetail(String id);
  Future<Result<CategoryModel>> createCategory(Map<String, dynamic> data);
  Future<Result<CategoryModel>> updateCategory(
    String id,
    Map<String, dynamic> data,
  );
  Future<Result<bool>> deleteCategory(String id);
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl extends BaseRemoteDataSource
    implements CategoryRemoteDataSource {
  CategoryRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<Result<List<CategoryModel>>> getCategories({
    Map<String, dynamic>? params,
  }) async {
    return _apiClient.getResult(ApiConstants.categories, (json) {
      final list = (json['item']['category'] ?? json) as List;
      return list.map((e) => CategoryModel.fromJson(e)).toList();
    }, queryParameters: params);
  }

  @override
  Future<Result<CategoryModel>> getCategoryDetail(String id) {
    return _apiClient.getResult(
      '${ApiConstants.categories}/$id',
      (json) => CategoryModel.fromJson(json['data'] ?? json),
    );
  }

  @override
  Future<Result<CategoryModel>> createCategory(Map<String, dynamic> data) {
    return _apiClient.postResult(
      ApiConstants.categories,
      (json) => CategoryModel.fromJson(json['data'] ?? json),
      data: data,
    );
  }

  @override
  Future<Result<CategoryModel>> updateCategory(
    String id,
    Map<String, dynamic> data,
  ) {
    return _apiClient.putResult(
      '${ApiConstants.categories}/$id',
      (json) => CategoryModel.fromJson(json['data'] ?? json),
      data: data,
    );
  }

  @override
  Future<Result<bool>> deleteCategory(String id) {
    return _apiClient.deleteResult('${ApiConstants.categories}/$id');
  }
}
