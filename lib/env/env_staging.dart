import 'package:envied/envied.dart';

part 'env_staging.g.dart';

@Envied(path: '.env.staging')
abstract class EnvStaging {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _EnvStaging.apiBaseUrl;

  @EnviedField(varName: 'WS_URL')
  static const String wsUrl = _EnvStaging.wsUrl;

  @EnviedField(varName: 'ENABLE_LOGGING', defaultValue: true)
  static const bool enableLogging = _EnvStaging.enableLogging;

  @EnviedField(varName: 'ENABLE_DEBUG_TOOLS', defaultValue: false)
  static const bool enableDebugTools = _EnvStaging.enableDebugTools;

  @EnviedField(varName: 'ENABLE_ANALYTICS', defaultValue: true)
  static const bool enableAnalytics = _EnvStaging.enableAnalytics;

  @EnviedField(varName: 'CONNECT_TIMEOUT', defaultValue: 30)
  static const int connectTimeout = _EnvStaging.connectTimeout;

  @EnviedField(varName: 'RECEIVE_TIMEOUT', defaultValue: 30)
  static const int receiveTimeout = _EnvStaging.receiveTimeout;

  @EnviedField(varName: 'GOOGLE_MAPS_API_KEY', obfuscate: true)
  static final String googleMapsApiKey = _EnvStaging.googleMapsApiKey;

  @EnviedField(varName: 'STRIPE_PUBLIC_KEY', obfuscate: true)
  static final String stripePublicKey = _EnvStaging.stripePublicKey;
}
