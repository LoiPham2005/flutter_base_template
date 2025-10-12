// import 'package:flutter/material.dart';
// // lib/main.dart - Setup hoàn chỉnh
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_base_template/core/config/flavor_config.dart';
// import 'package:flutter_base_template/routes/app_router.dart';
// import 'core/config/app_config.dart';
// import 'core/config/environment_config.dart';
// import 'core/theme/app_theme.dart';
// import 'core/storage/local_storage.dart';
// import 'core/utils/logger.dart';
// import 'core/services/navigation_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   // Initialize app
//   await initializeApp();
  
//   runApp(const MyApp());
// }

// Future<void> initializeApp() async {
//   try {
//     // 1️⃣ Chỉ cho phép xoay dọc
//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);

//     // 2️⃣ Setup thanh status bar
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//     );

//     // 3️⃣ Cấu hình logger
//     Logger.configure(enabled: true, minLevel: LogLevel.debug);

//     // 4️⃣ Chọn môi trường (DEV, STAGING, PROD)
//     EnvironmentConfig.setEnvironment(Environment.development);

//     // 5️⃣ Setup Flavor tương ứng
//     FlavorConfig(
//       flavor: Flavor.development,
//       name: "Development",
//       baseUrl: EnvironmentConfig.baseUrl,
//       isDebug: true,
//     );

//     // 6️⃣ Setup AppConfig
//     AppConfig.initialize(
//       appName: "My Flutter Base App",
//       baseUrl: EnvironmentConfig.baseUrl,
//       debugMode: FlavorConfig.instance.isDebug,
//       environment: FlavorConfig.instance.name,
//     );

//     // 7️⃣ Khởi tạo Local Storage
//     await LocalStorage.getInstance();

//     Logger.info("✅ App initialized successfully in ${FlavorConfig.instance.name}");
//   } catch (e, stack) {
//     Logger.error("❌ Failed to initialize app", error: e, stackTrace: stack);
//   }
// }



// lib/main_dev.dart
import 'package:flutter_base_template/core/common/main_common.dart';

import 'core/config/environment_config.dart';

void main() => runMainApp(Environment.development);
