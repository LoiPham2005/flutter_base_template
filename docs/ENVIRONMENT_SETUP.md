# 🌍 Environment Setup Guide

## Cấu hình Environment (Dev/Staging/Prod)

Dự án sử dụng **--dart-define=ENV** thay vì Flavors để quản lý environments. Đơn giản hơn, dễ maintain hơn.

### Quick Setup

```bash
# Development
flutter run --dart-define=ENV=dev

# Staging
flutter run --dart-define=ENV=staging

# Production
flutter run --dart-define=ENV=prod
```

### VS Code Setup

File: [launch.json](http://_vscodecontentref_/10)

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "🧑‍💻 Development",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--dart-define=ENV=dev"],
      "flutterMode": "debug"
    },
    {
      "name": "🧪 Staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--dart-define=ENV=staging"],
      "flutterMode": "debug"
    },
    {
      "name": "🚀 Production",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--dart-define=ENV=prod"],
      "flutterMode": "debug"
    }
  ]
}
```

### Environment Configuration

File: [environment_config.dart](http://_vscodecontentref_/11)

```dart
enum Environment { development, staging, production }

class EnvironmentConfig {
  static const String _envString = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  static Environment get environment {
    switch (_envString.toLowerCase()) {
      case 'dev':
      case 'development':
        return Environment.development;
      case 'stg':
      case 'staging':
        return Environment.staging;
      case 'prod':
      case 'production':
        return Environment.production;
      default:
        return Environment.development;
    }
  }

  // API URLs
  static String get apiBaseUrl {
    switch (environment) {
      case Environment.development:
        return 'http://192.168.1.100:3000/api';
      case Environment.staging:
        return 'https://api-staging.example.com';
      case Environment.production:
        return 'https://api.example.com';
    }
  }

  // App Name
  static String get appName {
    switch (environment) {
      case Environment.development:
        return 'My App (Dev)';
      case Environment.staging:
        return 'My App (Staging)';
      case Environment.production:
        return 'My App';
    }
  }

  // Debug Settings
  static bool get isDev => environment == Environment.development;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProduction => environment == Environment.production;

  static bool get enableLogging => !isProduction;
  static bool get enableDebugTools => isDev;
}
```

### Build Commands

```bash
# ============= DEVELOPMENT =============
flutter run --dart-define=ENV=dev
flutter build apk --dart-define=ENV=dev

# ============= STAGING =============
flutter run --dart-define=ENV=staging
flutter build apk --dart-define=ENV=staging

# ============= PRODUCTION =============
flutter run --dart-define=ENV=prod
flutter build apk --release --dart-define=ENV=prod
flutter build appbundle --release --dart-define=ENV=prod
```

### CI/CD Integration

File: `.github/workflows/build.yml`

```yaml
name: Build

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        env: [dev, staging, prod]
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      
      - run: flutter pub get
      - run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Build APK (${{ matrix.env }})
        run: flutter build apk --dart-define=ENV=${{ matrix.env }}
      
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: app-${{ matrix.env }}.apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

### Why Not Flavors?

| Tiêu chí | Flavors | --dart-define |
|----------|---------|---------------|
| Setup | 🔴 Phức tạp | 🟢 Đơn giản |
| Maintenance | 🔴 2 nơi cấu hình | 🟢 1 file |
| Rebuild | 🔴 Cần rebuild | 🟢 Không cần |
| Scalability | 🔴 Khó thêm env | 🟢 Dễ thêm |

**Kết luận**: --dart-define đủ cho 99% use cases.