import 'package:get_it/get_it.dart';
import 'register_services.dart';

final GetIt getIt = GetIt.instance;

/// Gọi để khởi tạo tất cả dependency khi app start
Future<void> setupDependencyInjection() async {
  await registerServices();
}
