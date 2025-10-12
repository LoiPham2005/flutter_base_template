// lib/core/config/flavor_config.dart
enum Flavor {
  development,
  staging,
  production,
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String baseUrl;
  final bool isDebug;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required String baseUrl,
    required bool isDebug,
  }) {
    _instance ??= FlavorConfig._internal(flavor, name, baseUrl, isDebug);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.baseUrl, this.isDebug);

  static FlavorConfig get instance {
    assert(_instance != null, '⚠️ FlavorConfig chưa được khởi tạo');
    return _instance!;
  }

  static bool get isDevelopment => instance.flavor == Flavor.development;
  static bool get isStaging => instance.flavor == Flavor.staging;
  static bool get isProduction => instance.flavor == Flavor.production;
}
