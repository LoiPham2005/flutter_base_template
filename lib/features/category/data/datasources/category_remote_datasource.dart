// lib/features/category/data/datasources/category_remote_datasource.dart
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({Map<String, dynamic>? params});
  Future<CategoryModel> getCategoryDetail(String id);
  Future<CategoryModel> createCategory(Map<String, dynamic> data);
  Future<CategoryModel> updateCategory(String id, Map<String, dynamic> data);
  Future<bool> deleteCategory(String id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final DioClient dioClient;
  
  CategoryRemoteDataSourceImpl(this.dioClient);
  
  @override
  Future<List<CategoryModel>> getCategories({Map<String, dynamic>? params}) async {
    try {
      final response = await dioClient.get(
        '/categories',
        queryParameters: params,
      );
      
      final List data = response.data['data'] ?? response.data;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: 'Không thể tải danh sách danh mục');
    }
  }
  
  @override
  Future<CategoryModel> getCategoryDetail(String id) async {
    try {
      final response = await dioClient.get('/categories/$id');
      return CategoryModel.fromJson(response.data['data'] ?? response.data);
    } catch (e) {
      throw ServerException(message: 'Không thể tải chi tiết danh mục');
    }
  }
  
  @override
  Future<CategoryModel> createCategory(Map<String, dynamic> data) async {
    try {
      final response = await dioClient.post('/categories', data: data);
      return CategoryModel.fromJson(response.data['data'] ?? response.data);
    } catch (e) {
      throw ServerException(message: 'Không thể tạo danh mục');
    }
  }
  
  @override
  Future<CategoryModel> updateCategory(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dioClient.put('/categories/$id', data: data);
      return CategoryModel.fromJson(response.data['data'] ?? response.data);
    } catch (e) {
      throw ServerException(message: 'Không thể cập nhật danh mục');
    }
  }
  
  @override
  Future<bool> deleteCategory(String id) async {
    try {
      await dioClient.delete('/categories/$id');
      return true;
    } catch (e) {
      throw ServerException(message: 'Không thể xóa danh mục');
    }
  }
}