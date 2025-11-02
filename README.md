# 🚀 Flutter Base Template

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.22.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.4.0+-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS-blue.svg)

**Production-ready Flutter template với Clean Architecture, DI, State Management, Flavors, và Environment Config**

[Tài liệu](#-documentation) • [Bắt đầu](#-quick-start) • [Tính năng](#-features) • [Cấu trúc](#-project-structure) • [Architecture](#-architecture-flow)

</div>

---

## ✨ Features

- 🏗️ **Clean Architecture** - Domain, Data, Presentation layers
- 📁 **Feature-First** - Tổ chức theo tính năng, dễ scale
- 💉 **DI tự động** - get_it + injectable
- 🔄 **State Management** - BLoC, GetX, Riverpod, Provider
- 🌐 **Networking** - Dio + Interceptors + Result wrapper
- 🔒 **Storage** - SharedPreferences + SecureStorage
- 🎨 **Theme** - Light/Dark mode
- 🌍 **i18n** - Multi-language với .arb
- 📱 **Responsive** - Screen utilities
- 🧪 **Testing** - Unit, Widget, Integration tests
- ⚙️ **Environment Config** - Flavors + --dart-define (Dev, Staging, Prod)
- 🔥 **CI/CD** - GitHub Actions

---

## 🚀 Quick Start

```bash
# 1. Clone & install
git clone <your-repo-url>
cd flutter_base_template
flutter pub get

# 2. Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Run (chọn environment & flavor)
flutter run --flavor development -t lib/main.dart --dart-define=ENV=dev              # Development
flutter run --flavor staging -t lib/main.dart --dart-define=ENV=staging              # Staging
flutter run --flavor production -t lib/main.dart --dart-define=ENV=prod              # Production
```

**VS Code**: Nhấn `F5` → Chọn flavor → Run

---

## 📂 Project Structure

```
lib/
├── core/                   # Core functionalities, shared across the app
│   ├── config/             # App initialization & configuration (Observer, Initializer)
│   ├── constants/          # Constants (API endpoints, App info)
│   ├── di/                 # Dependency Injection (get_it, injectable)
│   ├── errors/             # Error handling (Failures, Exceptions)
│   ├── extensions/         # Utility extensions
│   ├── l10n/               # Localization (multi-language support)
│   ├── network/            # Network layer (Dio, Interceptors, API Client)
│   ├── services/           # Core services (Notifications, Dialogs)
│   ├── state_management/   # Base classes for BLoC, GetX, Riverpod
│   ├── storage/            # Data storage (SharedPreferences, Secure Storage)
│   ├── theme/              # UI management (Colors, Styles, Themes)
│   └── utils/              # Utilities (Logger, Validators)
│
├── features/               # App features
│   ├── auth/               # Example: Authentication feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── ...                 # Other features
│
└── shared/                 # Shared UI components
    ├── models/             # Shared models
    └── widgets/            # Reusable widgets
```

---

## 📚 Documentation

### Bắt đầu
- 📖 [Getting Started](docs/GETTING_STARTED.md) - Setup chi tiết
- 🎨 [Rename Project](docs/RENAME_PROJECT.md) - Đổi tên dự án

### Phát triển
- 🏗️ [Architecture](docs/ARCHITECTURE.md) - Clean Architecture
- 🔌 [API Implementation](docs/API_IMPLEMENTATION.md) - Thêm API
- 🔄 [State Management](docs/STATE_MANAGEMENT.md) - BLoC, GetX, Riverpod
- ✨ [Features Guide](docs/FEATURES_GUIDE.md) - Tạo feature mới
- 📝 [Coding Standards](docs/CODING_STANDARDS.md) - Quy tắc code

### Build & Deploy
- 🚀 [Build & Deploy](docs/BUILD_AND_DEPLOY.md) - Release app
- 🧪 [Testing](docs/TESTING.md) - Viết tests
- ❓ [FAQ](docs/FAQ.md) - Giải đáp

### Đóng góp
- 🤝 [Contributing](docs/CONTRIBUTING.md) - Cách contribute

---

## ⚡ Build & Run Commands (With Flavors)

### 1. Code Generation (Build Runner)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 2. Generate Localization (i18n)

```bash
flutter gen-l10n
```

### 3. Clean Project

```bash
flutter clean
flutter pub get
```

### 4. Build APK (With Flavors)

```bash
flutter build apk --flavor development -t lib/main.dart
flutter build apk --flavor staging -t lib/main.dart
flutter build apk --flavor production -t lib/main.dart
```

### 5. Build AAB (App Bundle - For Google Play, With Flavors)

```bash
flutter build appbundle --flavor development -t lib/main.dart
flutter build appbundle --flavor staging -t lib/main.dart
flutter build appbundle --flavor production -t lib/main.dart
```

### 6. Build iOS (With Flavors)

```bash
flutter build ios --flavor development -t lib/main.dart
flutter build ios --flavor staging -t lib/main.dart
flutter build ios --flavor production -t lib/main.dart
```

### 7. Run on Device/Emulator (With Flavors)

```bash
flutter run --flavor development -t lib/main.dart
flutter run --flavor staging -t lib/main.dart
flutter run --flavor production -t lib/main.dart
```

### 8. (Optional) Kết hợp --dart-define nếu cần truyền ENV cho code Dart

```bash
flutter run --flavor development -t lib/main.dart --dart-define=ENV=dev
flutter run --flavor staging -t lib/main.dart --dart-define=ENV=staging
flutter run --flavor production -t lib/main.dart --dart-define=ENV=prod
```

### 9. Upgrade Dependencies

```bash
flutter pub upgrade
flutter pub outdated
```

### 10. Code Analysis & Formatting

```bash
flutter analyze
flutter format .
```

### 11. Run Tests

```bash
flutter test
flutter test test/features/auth/presentation/bloc/auth_bloc_test.dart
flutter test --coverage
```

---

## 📋 Quick Command Reference

| Task                | Command Example |
|---------------------|----------------|
| **Build APK Dev**   | `flutter build apk --flavor development -t lib/main.dart` |
| **Build APK Stg**   | `flutter build apk --flavor staging -t lib/main.dart` |
| **Build APK Prod**  | `flutter build apk --flavor production -t lib/main.dart` |
| **Build AAB Prod**  | `flutter build appbundle --flavor production -t lib/main.dart` |
| **Run Dev**         | `flutter run --flavor development -t lib/main.dart` |
| **Run Stg**         | `flutter run --flavor staging -t lib/main.dart` |
| **Run Prod**        | `flutter run --flavor production -t lib/main.dart` |
| **Code Gen**        | `flutter pub run build_runner build --delete-conflicting-outputs` |
| **i18n**            | `flutter gen-l10n` |
| **Clean**           | `flutter clean && flutter pub get` |
| **Analyze**         | `flutter analyze` |
| **Format**          | `flutter format .` |
| **Test**            | `flutter test` |

---

## 🎯 Typical Workflow

```bash
flutter clean && flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run --flavor development -t lib/main.dart --dart-define=ENV=dev
flutter build apk --flavor staging -t lib/main.dart --dart-define=ENV=staging
flutter build apk --flavor production -t lib/main.dart --dart-define=ENV=prod
```

---

## 📝 Notes

- **Flavors**: Đảm bảo đã cấu hình productFlavors trong `android/app/build.gradle.kts` và scheme/target trên iOS.
- **Entrypoint**: Nếu bạn có file main riêng cho từng flavor, thay `lib/main.dart` bằng file tương ứng.
- **Kết hợp --dart-define**: Nếu code Dart cần biết ENV, truyền thêm `--dart-define=ENV=...`.
- **Output**: APK/AAB sẽ nằm trong thư mục `build/app/outputs/`.

---

## 🛠️ Tech Stack

**Core**: Flutter 3.22+, Dart 3.4+  
**Architecture**: get_it, injectable  
**State**: flutter_bloc, get, riverpod, provider  
**Network**: dio, connectivity_plus  
**Storage**: shared_preferences, flutter_secure_storage  
**UI**: flutter_screenutil, cached_network_image  
**Dev**: build_runner, freezed, json_serializable  

---

## 🤝 Contributing

Contributions welcome! Xem [Contributing Guide](docs/CONTRIBUTING.md)

```bash
git checkout -b feature/amazing-feature
git commit -m 'feat: Add amazing feature'
git push origin feature/amazing-feature
```

---

## 📄 License

MIT License - see [LICENSE](LICENSE)

---

## 📞 Support

- 📧 Email: support@yourcompany.com
- 🐛 Issues: [GitHub Issues](https://github.com/yourrepo/issues)
- 📖 Docs: [Documentation](docs/)

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star nếu hữu ích!

</div>