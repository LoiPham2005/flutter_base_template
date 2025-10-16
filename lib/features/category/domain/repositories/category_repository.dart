// lib/features/category/domain/repositories/category_repository.dart
import 'package:flutter_base_template/core/state_management/repository_helper/base_response.dart';

import '../../../../core/errors/result.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Result<List<Category>>> getCategories({Map<String, dynamic>? params});
  Future<Result<Category>> getCategoryDetail(String id);
  Future<Result<Category>> createCategory(Map<String, dynamic> data);
  Future<Result<Category>> updateCategory(String id, Map<String, dynamic> data);
  Future<Result<bool>> deleteCategory(String id);
}

// abstract class CategoryRepository {
//   Future<BaseResponse<List<Category>>> getCategories({Map<String, dynamic>? params});
//   Future<BaseResponse<Category>> getCategoryDetail(String id);
//   Future<BaseResponse<Category>> createCategory(Map<String, dynamic> data);
//   Future<BaseResponse<Category>> updateCategory(String id, Map<String, dynamic> data);
//   Future<BaseResponse<bool>> deleteCategory(String id);
// }