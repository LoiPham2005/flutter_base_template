import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/config/environment_config.dart';
import 'package:flutter_base_template/features/my_app.dart';
import 'core/config/app_initializer.dart';

void mainCommon(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initialize();

  // Set environment
  EnvironmentConfig.setEnvironment(env);

  runApp(const MyApp());
}
