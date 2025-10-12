// // lib/features/category/presentation/bloc/category_bloc.dart
// import '../../../../core/bloc/data_bloc/data_bloc.dart';
// import '../../../../core/errors/result.dart';
// import '../../domain/entities/category.dart';
// import '../../domain/repositories/category_repository.dart';

// class CategoryBloc extends DataBloc<Category> {
//   final CategoryRepository repository;

//   CategoryBloc({required this.repository});

//   @override
//   Future<Result<List<Category>>> fetchList(Map<String, dynamic>? params) {
//     return repository.getCategories(params: params);
//   }

//   @override
//   Future<Result<Category>> fetchDetail(String id, Map<String, dynamic>? params) {
//     return repository.getCategoryDetail(id);
//   }

//   @override
//   Future<Result<Category>> create(Map<String, dynamic> data) {
//     return repository.createCategory(data);
//   }

//   @override
//   Future<Result<Category>> update(String id, Map<String, dynamic> data) {
//     return repository.updateCategory(id, data);
//   }

//   @override
//   Future<Result<bool>> delete(String id) {
//     return repository.deleteCategory(id);
//   }
// }

import 'package:flutter_base_template/core/state_management/bloc_cubit/base_cubit.dart';
import 'package:flutter_base_template/core/state_management/bloc_cubit/base_state.dart';
import 'package:flutter_base_template/core/errors/result.dart';
import 'package:flutter_base_template/features/category/domain/entities/category.dart';
import 'package:flutter_base_template/features/category/domain/repositories/category_repository.dart';

class CategoryBloc extends BaseCubit {
  final CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(InitialState());

  Future<Future<Result<List<Category>>?>> fetchList(Map<String, dynamic>? params) async {
     return performAction(
      action: () => repository.getCategories(params: params),
      loadingMessage: 'Đang đăng nhập...',
      successMessage: 'Đăng nhập thành công!',
    );
  }
}
