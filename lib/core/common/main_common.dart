import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/app/my_app.dart';
import 'package:flutter_base_template/core/config/app_config.dart';
import 'package:flutter_base_template/core/config/app_initializer.dart';
import 'package:flutter_base_template/core/state_management/bloc_cubit/app_bloc_observer.dart';

Future<void> runMainApp(AppEnvironment env) async {
  await AppInitializer.initialize();
  AppConfig.initialize(env);
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
