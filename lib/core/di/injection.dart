// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_base_template/core/network/dio_client.dart';
// import 'package:flutter_base_template/core/network/network_info.dart';
// import 'package:flutter_base_template/core/services/navigation_service.dart';
// import 'package:flutter_base_template/core/storage/local_storage.dart';
// import 'package:get_it/get_it.dart';
// import 'register_services.dart';

// final GetIt getIt = GetIt.instance;

// /// Gọi để khởi tạo tất cả dependency khi app start
// Future<void> setupDependencyInjection() async {
//   await registerServices();

//     // Core Services
//   getIt.registerLazySingleton(() => NavigationService());

//   // Storage
//   final localStorage = await LocalStorage.getInstance();
//   getIt.registerLazySingleton(() => localStorage);

//   // Network
//   getIt.registerLazySingleton(() => Connectivity());
//   getIt.registerLazySingleton<NetworkInfo>(
//     () => NetworkInfoImpl(getIt<Connectivity>()),
//   );
//   getIt.registerLazySingleton(() => DioClient());

//   // Features - Add your features here
//   // await setupAuthDependencies();
//   // await setupCategoryDependencies();
// }

// dùng gen code
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_base_template/core/di/injection.config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  // Cung cấp SharedPreferences
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // Cung cấp FlutterSecureStorage
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Cung cấp Connectivity
  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
