// // lib/features/category/data/repositories/category_repository_impl.dart
// import 'package:injectable/injectable.dart';

// import '../../../../core/errors/exceptions.dart';
// import '../../../../core/errors/failures.dart';
// import '../../../../core/errors/result.dart';
// import '../../../../core/network/network_info.dart';
// import '../../domain/entities/category.dart';
// import '../../domain/repositories/category_repository.dart';
// import '../datasources/category_remote_datasource.dart';

// class CategoryRepositoryImpl implements CategoryRepository {
//   final CategoryRemoteDataSource remoteDataSource;
//   final NetworkInfo networkInfo;

//   CategoryRepositoryImpl({
//     required this.remoteDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Result<List<Category>>> getCategories({
//     Map<String, dynamic>? params,
//   }) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final categories = await remoteDataSource.getCategories(params: params);
//         return Success(categories.map((model) => model.toEntity()).toList());
//       } on ServerException catch (e) {
//         return Error(ServerFailure(message: e.message));
//       } catch (e) {
//         return Error(UnknownFailure(message: e.toString()));
//       }
//     } else {
//       return const Error(NetworkFailure());
//     }
//   }

//   @override
//   Future<Result<Category>> getCategoryDetail(String id) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final category = await remoteDataSource.getCategoryDetail(id);
//         return Success(category.toEntity());
//       } on ServerException catch (e) {
//         return Error(ServerFailure(message: e.message));
//       } catch (e) {
//         return Error(UnknownFailure(message: e.toString()));
//       }
//     } else {
//       return const Error(NetworkFailure());
//     }
//   }

//   @override
//   Future<Result<Category>> createCategory(Map<String, dynamic> data) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final category = await remoteDataSource.createCategory(data);
//         return Success(category.toEntity());
//       } on ServerException catch (e) {
//         return Error(ServerFailure(message: e.message));
//       } catch (e) {
//         return Error(UnknownFailure(message: e.toString()));
//       }
//     } else {
//       return const Error(NetworkFailure());
//     }
//   }

//   @override
//   Future<Result<Category>> updateCategory(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final category = await remoteDataSource.updateCategory(id, data);
//         return Success(category.toEntity());
//       } on ServerException catch (e) {
//         return Error(ServerFailure(message: e.message));
//       } catch (e) {
//         return Error(UnknownFailure(message: e.toString()));
//       }
//     } else {
//       return const Error(NetworkFailure());
//     }
//   }

//   @override
//   Future<Result<bool>> deleteCategory(String id) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final result = await remoteDataSource.deleteCategory(id);
//         return Success(result);
//       } on ServerException catch (e) {
//         return Error(ServerFailure(message: e.message));
//       } catch (e) {
//         return Error(UnknownFailure(message: e.toString()));
//       }
//     } else {
//       return const Error(NetworkFailure());
//     }
//   }
// }

import 'package:injectable/injectable.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/network/base_repository.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl extends BaseRepository
    implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  CategoryRepositoryImpl(this._remoteDataSource, this._networkInfo)
      : super(_networkInfo);

  @override
  Future<Result<List<Category>>> getCategories({Map<String, dynamic>? params}) {
    return safeCall(() async {
      final result = await _remoteDataSource.getCategories(params: params);
      
      // ✅ Map list of models to list of entities
      return result.map(
        (models) => models.map((model) => model.toEntity()).toList(),
      );
    });
  }

  @override
  Future<Result<Category>> getCategoryDetail(String id) {
    return safeCall(() async {
      final result = await _remoteDataSource.getCategoryDetail(id);
      
      // ✅ Map single model to entity
      return result.map((model) => model.toEntity());
    });
  }

  @override
  Future<Result<Category>> createCategory(Map<String, dynamic> data) {
    return safeCall(() async {
      final result = await _remoteDataSource.createCategory(data);
      
      // ✅ Map single model to entity
      return result.map((model) => model.toEntity());
    });
  }

  @override
  Future<Result<Category>> updateCategory(String id, Map<String, dynamic> data) {
    return safeCall(() async {
      final result = await _remoteDataSource.updateCategory(id, data);
      
      // ✅ Map single model to entity
      return result.map((model) => model.toEntity());
    });
  }

  @override
  Future<Result<bool>> deleteCategory(String id) {
    // ✅ Không cần map vì trả về bool
    return safeCall(() => _remoteDataSource.deleteCategory(id));
  }
}