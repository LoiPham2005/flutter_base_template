// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/category/data/datasources/category_remote_datasource.dart'
    as _i88;
import '../../features/category/data/repositories/category_repository_impl.dart'
    as _i528;
import '../../features/category/domain/repositories/category_repository.dart'
    as _i869;
import '../../features/category/domain/usecases/category_usecases.dart'
    as _i514;
import '../../features/category/presentation/bloc/category_bloc.dart' as _i292;
import '../config/app_config.dart' as _i650;
import '../l10n/localization_service.dart' as _i502;
import '../network/api_client.dart' as _i557;
import '../network/base_repository.dart' as _i393;
import '../network/dio_client.dart' as _i667;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/interceptors/error_interceptor.dart' as _i511;
import '../network/interceptors/logging_interceptor.dart' as _i344;
import '../network/network_info.dart' as _i932;
import '../storage/secure_storage.dart' as _i619;
import '../storage/storage_service.dart' as _i865;
import '../theme/theme_service.dart' as _i499;
import '../utils/check_auth_service.dart' as _i476;
import 'injection.dart' as _i464;

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
    gh.lazySingleton<_i511.ErrorInterceptor>(() => _i511.ErrorInterceptor());
    gh.lazySingleton<_i344.LoggingInterceptor>(
      () => _i344.LoggingInterceptor(),
    );
    gh.lazySingleton<_i865.StorageService>(
      () => _i865.StorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i619.SecureStorage>(
      () => _i619.SecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i745.AuthInterceptor>(
      () => _i745.AuthInterceptor(gh<_i865.StorageService>()),
    );
    gh.lazySingleton<_i502.LocalizationService>(
      () => _i502.LocalizationService(gh<_i865.StorageService>()),
    );
    gh.lazySingleton<_i499.ThemeService>(
      () => _i499.ThemeService(gh<_i865.StorageService>()),
    );
    gh.lazySingleton<_i869.CategoryRepository>(
      () => _i528.CategoryRepositoryImpl(
        gh<_i88.CategoryRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i393.BaseRepository>(
      () => _i393.BaseRepository(gh<_i932.NetworkInfo>()),
    );
    gh.lazySingleton<_i667.DioClient>(
      () => _i667.DioClient(
        gh<_i650.AppConfig>(),
        gh<_i745.AuthInterceptor>(),
        gh<_i511.ErrorInterceptor>(),
        gh<_i344.LoggingInterceptor>(),
      ),
    );
    gh.factory<_i514.GetCategoriesUseCase>(
      () => _i514.GetCategoriesUseCase(gh<_i869.CategoryRepository>()),
    );
    gh.factory<_i514.GetCategoryDetailUseCase>(
      () => _i514.GetCategoryDetailUseCase(gh<_i869.CategoryRepository>()),
    );
    gh.factory<_i292.CategoryBloc>(
      () => _i292.CategoryBloc(
        getCategoriesUseCase: gh<_i514.GetCategoriesUseCase>(),
      ),
    );
    gh.lazySingleton<_i557.ApiClient>(
      () => _i557.ApiClient(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i88.CategoryRemoteDataSourceImpl>(
      () => _i88.CategoryRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i476.CheckAuthService>(
      () => _i476.CheckAuthService(
        gh<_i865.StorageService>(),
        gh<_i667.DioClient>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
