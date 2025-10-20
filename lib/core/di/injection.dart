import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_base_template/core/config/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' hide Environment; // 👈 Sửa dòng này
import 'package:shared_preferences/shared_preferences.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
// Sửa lại để nhận đúng enum Environment của bạn
Future<void> configureDependencies({required Environment env}) async {
  // ✅ Đăng ký AppConfig từ enum
  getIt.registerSingleton<AppConfig>(AppConfig.fromEnvironment(env));

  // ✅ Chạy code generation của injectable, truyền vào tên của enum
  getIt.init(environment: env.name);
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
