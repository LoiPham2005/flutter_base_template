# 🌍 Environment Setup Guide

## Cấu hình Environment (Dev/Staging/Prod)

Dự án hỗ trợ **đa môi trường** (development, staging, production) bằng cách kết hợp **Flavors** và `--dart-define=ENV` để tối ưu cho cả native lẫn code Dart.

---

### 1. Quick Setup

```bash
# Development
flutter run --flavor development -t lib/main.dart --dart-define=ENV=dev

# Staging
flutter run --flavor staging -t lib/main.dart --dart-define=ENV=staging

# Production
flutter run --flavor production -t lib/main.dart --dart-define=ENV=prod
```

---

### 2. VS Code Setup

File: `.vscode/launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "🧑‍💻 Development",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--flavor", "development", "--dart-define=ENV=dev"],
      "flutterMode": "debug"
    },
    {
      "name": "🧪 Staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--flavor", "staging", "--dart-define=ENV=staging"],
      "flutterMode": "debug"
    },
    {
      "name": "🚀 Production",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--flavor", "production", "--dart-define=ENV=prod"],
      "flutterMode": "debug"
    }
  ]
}
```

---

### 3. Environment Configuration

File: [`lib/core/config/environment_config.dart`](lib/core/config/environment_config.dart)

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
        return ApiConstants.baseUrlDev;
      case Environment.staging:
        return ApiConstants.baseUrlStaging;
      case Environment.production:
        return ApiConstants.baseUrlProd;
    }
  }

  // App Name
  static String get appName {
    switch (environment) {
      case Environment.development:
        return 'MyApp Dev';
      case Environment.staging:
        return 'MyApp Staging';
      case Environment.production:
        return 'MyApp';
    }
  }

  // ... (Các getter khác: bundleId, webSocketUrl, enableLogging, ...)
}
```

---

### 4. Build Commands

```bash
# ============= DEVELOPMENT =============
flutter run --flavor development -t lib/main.dart --dart-define=ENV=dev
flutter build apk --flavor development -t lib/main.dart --dart-define=ENV=dev

# ============= STAGING =============
flutter run --flavor staging -t lib/main.dart --dart-define=ENV=staging
flutter build apk --flavor staging -t lib/main.dart --dart-define=ENV=staging

# ============= PRODUCTION =============
flutter run --flavor production -t lib/main.dart --dart-define=ENV=prod
flutter build apk --flavor production -t lib/main.dart --dart-define=ENV=prod
flutter build appbundle --flavor production -t lib/main.dart --dart-define=ENV=prod
```

---

### 5. Android Flavors Setup

File: [`android/app/build.gradle.kts`](android/app/build.gradle.kts)

```kotlin
flavorDimensions += "environment"
productFlavors {
    create("development") {
        dimension = "environment"
        applicationIdSuffix = ".dev"
        versionNameSuffix = "-dev"
        resValue("string", "app_name", "MyApp Dev")
    }
    create("staging") {
        dimension = "environment"
        applicationIdSuffix = ".stg"
        versionNameSuffix = "-stg"
        resValue("string", "app_name", "MyApp Staging")
    }
    create("production") {
        dimension = "environment"
        resValue("string", "app_name", "MyApp")
    }
}
```

- Tạo folder `android/app/src/development/`, `staging/`, `production/` nếu cần custom icon, manifest, google-services.json riêng.

---

### 6. iOS Flavors Setup

- Tạo scheme và target cho từng flavor trong Xcode: Development, Staging, Production.
- Đặt Bundle Identifier, tên app, icon, file Firebase riêng cho từng target.
- Tham khảo thêm trong tài liệu [docs/rename_project.md](docs/rename_project.md).

---

### 7. CI/CD Integration

File: `.github/workflows/build.yml`

```yaml
name: Build

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        env: [development, staging, production]
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter pub run build_runner build --delete-conflicting-outputs
      - run: flutter analyze
      - run: flutter test
      - name: Build APK (${{ matrix.env }})
        run: flutter build apk --flavor ${{ matrix.env }} -t lib/main.dart --dart-define=ENV=${{ matrix.env }}
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: app-${{ matrix.env }}.apk
          path: build/app/outputs/flutter-apk/app-${{ matrix.env }}-release.apk
```

---

### 8. So sánh Flavors & --dart-define

| Tiêu chí      | Flavors (native) | --dart-define (Dart) | Kết hợp (Best) |
|---------------|------------------|----------------------|----------------|
| Đổi appId     | ✅               | ❌                   | ✅             |
| Đổi tên app   | ✅               | ❌                   | ✅             |
| Đổi icon      | ✅               | ❌                   | ✅             |
| Đổi API/config| 🟡 (phức tạp)    | ✅                   | ✅             |
| Đổi Firebase  | ✅               | ❌                   | ✅             |
| CI/CD         | �               | ✅                   | ✅             |
| Đa nền tảng   | ❌ (native only) | ✅                   | ✅             |

**Khuyến nghị:**  
- Dùng **Flavors** cho native (appId, icon, tên app, Firebase, cài song song).
- Dùng **--dart-define=ENV** cho config trong code Dart.
- **Kết hợp cả 2** để tối ưu cho dự án production chuyên nghiệp.

---

### 9. Notes

- **Luôn truyền đúng cả flavor và ENV khi build/run.**
- **Nếu chỉ cần đổi API/config, có thể chỉ dùng --dart-define.**
- **Nếu cần đổi appId, icon, tên app, Firebase, phải dùng Flavors.**
- **Tham khảo thêm:**  
  - [docs/build_flavor.md](build_flavor.md)  
  - [docs/architecture.md](architecture.md)  
  - [docs/rename_project.md](rename_project.md)

---