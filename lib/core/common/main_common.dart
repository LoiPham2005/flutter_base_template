import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base_template/core/app/app_widget_binding.dart';
import 'package:flutter_base_template/core/app/my_app.dart';
import 'package:flutter_base_template/core/state_management/bloc_cubit/app_bloc_observer.dart';
import 'package:flutter_base_template/core/config/app_config.dart';
import 'package:flutter_base_template/core/config/environment_config.dart';
import 'package:flutter_base_template/core/config/flavor_config.dart';
import 'package:flutter_base_template/core/config/initialize_app.dart';
import 'package:flutter_base_template/core/di/injection.dart';

/// Entry point khởi chạy toàn bộ ứng dụng
Future<void> runMainApp(Environment env) async {
  /// 1️⃣ Đảm bảo các binding hệ thống Flutter được khởi tạo
  await AppWidgetBinding.ensureInitialized();

  /// 2️⃣ Khởi tạo Dependency Injection (GetIt, Service Locator, v.v)
  await setupDependencyInjection();

  /// 3️⃣ Thiết lập Bloc Observer để theo dõi thay đổi state toàn app
  Bloc.observer = AppBlocObserver();

  /// 4️⃣ Thiết lập các cấu hình khởi tạo: orientation, system UI, logger...
  await InitializeApp();

  /// 5️⃣ Thiết lập môi trường & flavor (baseUrl, tên app, chế độ debug)
  EnvironmentConfig.setEnvironment(env);
  FlavorConfig(
    flavor: _mapEnvToFlavor(env),
    name: env.name,
    baseUrl: EnvironmentConfig.baseUrl,
    isDebug: env == Environment.development,
  );

  /// 6️⃣ Cấu hình thông tin ứng dụng
  AppConfig.initialize(
    appName: 'My Flutter App (${env.name})',
    baseUrl: EnvironmentConfig.baseUrl,
    debugMode: env == Environment.development,
    environment: env.name,
  );

  /// 7️⃣ Chạy ứng dụng chính
  runApp(const MyApp());
}

/// Map từ Environment → Flavor
Flavor _mapEnvToFlavor(Environment env) {
  switch (env) {
    case Environment.development:
      return Flavor.development;
    case Environment.staging:
      return Flavor.staging;
    case Environment.production:
      return Flavor.production;
  }
}
