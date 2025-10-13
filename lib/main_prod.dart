// lib/main_prod.dart
import 'package:flutter_base_template/core/common/main_common.dart';
import 'package:flutter_base_template/core/config/app_config.dart';

void main() => runMainApp(AppEnvironment.production);


  // Chỉ init analytics ở production
  // if (EnvConfig.enableAnalytics) { // ✅ Từ .env
  //   await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  // }
  
  // // Chỉ init Sentry nếu có DSN
  // if (EnvConfig.sentryDsn.isNotEmpty) {
  //   await SentryFlutter.init(
  //     (options) => options.dsn = EnvConfig.sentryDsn,
  //   );
  // }