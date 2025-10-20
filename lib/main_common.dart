import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/my_app.dart';
import 'package:flutter_base_template/core/config/app_initializer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_template/core/config/app_bloc_observer.dart';

Future<void> mainCommon(String flavor) async {
  // Đảm bảo các binding đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo toàn bộ ứng dụng với flavor tương ứng
  await AppInitializer.initialize(flavorflavor: flavor);

  // Chỉ bật Bloc Observer ở chế độ debug
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }

  // Chạy ứng dụng
  runApp(const MyApp());
}