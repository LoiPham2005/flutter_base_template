import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/config/environment_config.dart';
import 'package:flutter_base_template/features/my_app.dart';
import 'package:flutter_base_template/core/config/app_initializer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/config/app_bloc_observer.dart';

Future<void> mainCommon(Environment env) async {
  // Đảm bảo các binding đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // Set environment
  EnvironmentConfig.setEnvironment(env);

  // Khởi tạo toàn bộ ứng dụng với flavor tương ứng
  await AppInitializer.initialize();

  // Chạy ứng dụng
  runApp(const MyApp());
}
