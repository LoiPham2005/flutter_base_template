// import 'package:flutter_base_template/core/network/network_info.dart';
// import 'package:flutter_base_template/features/category/data/datasources/category_remote_datasource.dart';
// import 'package:flutter_base_template/features/category/data/repositories/category_repository_impl.dart';
// import 'package:flutter_base_template/features/category/domain/repositories/category_repository.dart';
// import 'package:flutter_base_template/features/category/presentation/bloc/category_bloc.dart';
// import 'package:get_it/get_it.dart';
// import '../services/navigation_service.dart';
// import '../services/dialog_service.dart';
// import '../network/api_client.dart';
// import '../network/dio_client.dart';
// import '../storage/local_storage.dart';

// final GetIt getIt = GetIt.instance;

// Future<void> registerServices() async {
//   // Services
//   getIt.registerSingleton<NavigationService>(NavigationService());
//   getIt.registerSingleton<DialogService>(DialogService());

//   // Storage
//   final storage = await LocalStorage.getInstance();
//   getIt.registerSingleton<LocalStorage>(storage);

//   // Network
//   getIt.registerLazySingleton<DioClient>(() => DioClient());
//   getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<DioClient>()));

//   // Repository / UseCase
//   // getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
//   // getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));

//     // DataSource
//   getIt.registerLazySingleton<CategoryRemoteDataSource>(
//     () => CategoryRemoteDataSourceImpl(getIt<DioClient>()),
//   );
  
//   // Repository
//   getIt.registerLazySingleton<CategoryRepository>(
//     () => CategoryRepositoryImpl(
//       remoteDataSource: getIt<CategoryRemoteDataSource>(),
//       networkInfo: getIt<NetworkInfo>(),
//     ),
//   );
  
//   // BLoC
//   getIt.registerFactory(
//     () => CategoryBloc(repository: getIt<CategoryRepository>()),
//   );
// }
