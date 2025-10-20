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
import 'package:flutter_base_template/core/config/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({required String flavor}) async {
  // Đăng ký AppConfig một cách tường minh dựa trên flavor
  getIt.registerSingleton<AppConfig>(AppConfig.fromFlavor(flavor));

  // Chạy code generation của injectable
  getIt.init();
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
