// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_base_template/core/di/injection.dart' as _i125;
import 'package:flutter_base_template/core/l10n/localization_service.dart'
    as _i238;
import 'package:flutter_base_template/core/network/api_client.dart' as _i278;
import 'package:flutter_base_template/core/network/base_repository.dart'
    as _i414;
import 'package:flutter_base_template/core/network/dio_client.dart' as _i858;
import 'package:flutter_base_template/core/network/interceptors/auth_interceptor.dart'
    as _i7;
import 'package:flutter_base_template/core/network/interceptors/error_interceptor.dart'
    as _i127;
import 'package:flutter_base_template/core/network/interceptors/logging_interceptor.dart'
    as _i261;
import 'package:flutter_base_template/core/network/network_info.dart' as _i978;
import 'package:flutter_base_template/core/storage/secure_storage.dart'
    as _i873;
import 'package:flutter_base_template/core/storage/storage_service.dart'
    as _i223;
import 'package:flutter_base_template/core/theme/theme_service.dart' as _i564;
import 'package:flutter_base_template/core/utils/check_auth_service.dart'
    as _i286;
import 'package:flutter_base_template/features/auth/data/datasources/auth_remote_datasourse.dart'
    as _i348;
import 'package:flutter_base_template/features/auth/data/repositories/auth_repository_impl.dart'
    as _i229;
import 'package:flutter_base_template/features/auth/domain/repositories/auth_repository.dart'
    as _i785;
import 'package:flutter_base_template/features/auth/domain/usecases/login_usecase.dart'
    as _i468;
import 'package:flutter_base_template/features/auth/presentation/bloc/auth_bloc.dart'
    as _i627;
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i127.ErrorInterceptor>(() => _i127.ErrorInterceptor());
    gh.lazySingleton<_i261.LoggingInterceptor>(
      () => _i261.LoggingInterceptor(),
    );
    gh.lazySingleton<_i223.StorageService>(
      () => _i223.StorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i873.SecureStorage>(
      () => _i873.SecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i978.NetworkInfo>(
      () => _i978.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i238.LocaleCubit>(
      () => _i238.LocaleCubit(gh<_i223.StorageService>()),
    );
    gh.lazySingleton<_i7.AuthInterceptor>(
      () => _i7.AuthInterceptor(gh<_i223.StorageService>()),
    );
    gh.lazySingleton<_i564.ThemeService>(
      () => _i564.ThemeService(gh<_i223.StorageService>()),
    );
    gh.lazySingleton<_i414.BaseRepository>(
      () => _i414.BaseRepository(gh<_i978.NetworkInfo>()),
    );
    gh.lazySingleton<_i858.DioClient>(
      () => _i858.DioClient(
        gh<_i7.AuthInterceptor>(),
        gh<_i127.ErrorInterceptor>(),
        gh<_i261.LoggingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i278.ApiClient>(
      () => _i278.ApiClient(gh<_i858.DioClient>()),
    );
    gh.lazySingleton<_i286.CheckAuthService>(
      () => _i286.CheckAuthService(
        gh<_i223.StorageService>(),
        gh<_i858.DioClient>(),
      ),
    );
    gh.lazySingleton<_i863.CategoryRemoteDataSource>(
      () => _i863.CategoryRemoteDataSourceImpl(gh<_i278.ApiClient>()),
    );
    gh.lazySingleton<_i348.AuthRemoteDataSource>(
      () => _i348.AuthRemoteDataSourceImpl(gh<_i278.ApiClient>()),
    );
    gh.lazySingleton<_i163.CategoryRepository>(
      () => _i800.CategoryRepositoryImpl(
        gh<_i863.CategoryRemoteDataSource>(),
        gh<_i978.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i785.AuthRepository>(
      () => _i229.AuthRepositoryImpl(
        gh<_i348.AuthRemoteDataSource>(),
        gh<_i978.NetworkInfo>(),
      ),
    );
    gh.factory<_i468.LoginUseCase>(
      () => _i468.LoginUseCase(gh<_i785.AuthRepository>()),
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
    gh.factory<_i627.AuthBloc>(
      () => _i627.AuthBloc(loginUseCase: gh<_i468.LoginUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i125.RegisterModule {}
