import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/my_app.dart';
import 'package:flutter_base_template/core/config/app_observer.dart';
import 'package:flutter_base_template/core/config/app_initializer.dart';
import 'package:flutter_base_template/core/config/app_bloc_observer.dart';

void main() async {
  // 1. Initialize core app features
  await AppInitializer.initialize();

  // 2. Initialize app lifecycle observer
  AppObserver().initialize();

  // 3. Initialize bloc observer (debug only)
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }

  // 4. Run app
  runApp(const MyApp());
}
