# 🚀 Flutter Base Template

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.22.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.4.0+-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS-blue.svg)

**Production-ready Flutter template với Clean Architecture, DI, và State Management đa dạng**

[Tài liệu](#-documentation) • [Bắt đầu](#-quick-start) • [Tính năng](#-features) • [Cấu trúc](#-project-structure)

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
- ⚙️ **Flavors** - Development, Staging, Production
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

# 3. Run
flutter run --flavor development -t lib/main_development.dart
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

## 🛠️ Tech Stack

**Core**: Flutter 3.22+, Dart 3.4+

**Architecture**: get_it, injectable

**State**: flutter_bloc, get, riverpod, provider

**Network**: dio, connectivity_plus

**Storage**: shared_preferences, flutter_secure_storage

**UI**: flutter_screenutil, cached_network_image

**Dev**: build_runner, freezed, json_serializable

---

## 🎯 Core Services

```dart
// Theme
final themeService = getIt<ThemeService>();
themeService.toggleTheme();

// Localization
final localizationService = getIt<LocalizationService>();
localizationService.changeLocale('en');
Text(context.tr.hello);

// Storage
final storage = getIt<StorageService>();
await storage.set('key', 'value');

// Secure Storage
final secure = getIt<SecureStorage>();
await secure.write(key: 'token', value: 'secret');
```

---

## ⚡ Commands

```bash
# Run flavors
flutter run --flavor development -t lib/main_development.dart
flutter run --flavor staging -t lib/main_staging.dart
flutter run --flavor production -t lib/main_production.dart

# Build
flutter build apk --release --flavor production -t lib/main_production.dart
flutter build appbundle --release --flavor production -t lib/main_production.dart
flutter build ios --release --flavor production -t lib/main_production.dart

# Code generation
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs

# Assets
flutter pub run flutter_launcher_icons:main --path=flutter_icons.yaml
flutter pub run flutter_native_splash:create --path=flutter_splash.yaml

# Quality
flutter analyze
flutter format .
flutter test
```

---

## 🎨 Customization

### Đổi tên dự án

```bash
# Cài đặt
dart pub global activate rename

# Đổi tên & bundle ID
dart run rename setAppName --value "Your App Name"
dart run rename setBundleId --value "com.yourcompany.yourapp"

# Clean
flutter clean && flutter pub get
```

Chi tiết: [RENAME_PROJECT.md](docs/RENAME_PROJECT.md)

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