// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_base_template/core/network/base_repository.dart'
    as _i414;
import 'package:flutter_base_template/core/network/dio_client.dart' as _i858;
import 'package:flutter_base_template/core/network/network_info.dart' as _i978;
import 'package:flutter_base_template/features/category/data/datasources/category_remote_datasource.dart'
    as _i863;
import 'package:flutter_base_template/features/category/data/repositories/category_repository_impl.dart'
    as _i800;
import 'package:flutter_base_template/features/category/domain/repositories/category_repository.dart'
    as _i163;
import 'package:flutter_base_template/features/category/domain/usecases/category_usecases.dart'
    as _i868;
import 'package:flutter_base_template/features/category/presentation/bloc/category_bloc.dart'
    as _i530;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i163.CategoryRepository>(
      () => _i800.CategoryRepositoryImpl(
        gh<_i863.CategoryRemoteDataSource>(),
        gh<_i978.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i863.CategoryRemoteDataSourceImpl>(
      () => _i863.CategoryRemoteDataSourceImpl(gh<_i858.DioClient>()),
    );
    gh.lazySingleton<_i414.BaseRepository>(
      () => _i414.BaseRepository(gh<_i978.NetworkInfo>()),
    );
    gh.factory<_i868.GetCategoriesUseCase>(
      () => _i868.GetCategoriesUseCase(gh<_i163.CategoryRepository>()),
    );
    gh.factory<_i868.GetCategoryDetailUseCase>(
      () => _i868.GetCategoryDetailUseCase(gh<_i163.CategoryRepository>()),
    );
    gh.factory<_i530.CategoryBloc>(
      () => _i530.CategoryBloc(
        getCategoriesUseCase: gh<_i868.GetCategoriesUseCase>(),
      ),
    );
    return this;
  }
}
