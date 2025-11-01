# 🚀 Flutter Build & Code Generation Commands

## 1. Code Generation (Build Runner)

Generate `.g.dart`, `.freezed.dart`, `.config.dart` files:

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 2. Generate Localization (i18n)

Generate localization files from `.arb`:

```bash
flutter gen-l10n
```

## 3. Clean Project

Remove build artifacts and regenerate:

```bash
flutter clean
flutter pub get
```

---

## 4. Build APK (Optimized Release)

Build APK with minification and debug symbols stripping:

### Development

```bash
flutter build apk --dart-define=ENV=dev
```

### Staging

```bash
flutter build apk --release --dart-define=ENV=staging --split-debug-info=build/debug-symbols
```

### Production (Optimized)

```bash
flutter build apk --release --dart-define=ENV=prod --split-debug-info=build/debug-symbols
```

**Output location:** `build/app/outputs/flutter-apk/app-release.apk`

---

## 5. Build AAB (App Bundle - For Google Play)

Build Android App Bundle with optimization:

### Production

```bash
flutter build appbundle --release --dart-define=ENV=prod --split-debug-info=build/debug-symbols
```

**Output location:** `build/app/outputs/bundle/release/app-release.aab`

---

## 6. Build iOS

### Development

```bash
flutter build ios --dart-define=ENV=dev
```

### Staging

```bash
flutter build ios --release --dart-define=ENV=staging --split-debug-info=build/debug-symbols
```

### Production

```bash
flutter build ios --release --dart-define=ENV=prod --split-debug-info=build/debug-symbols
```

---

## 7. Run on Device/Emulator

### Development

```bash
flutter run --dart-define=ENV=dev
```

### Staging

```bash
flutter run --dart-define=ENV=staging
```

### Production

```bash
flutter run --dart-define=ENV=prod
```

---

## 8. Upgrade Dependencies

Check and upgrade packages:

```bash
# Upgrade all packages
flutter pub upgrade

# Check for outdated packages
flutter pub outdated
```

---

## 9. Code Analysis & Formatting

### Analyze code for errors

```bash
flutter analyze
```

### Format code (Dart style)

```bash
flutter format .
```

---

## 10. Run Tests

### Unit & Widget Tests

```bash
flutter test
```

### Run specific test file

```bash
flutter test test/features/auth/presentation/bloc/auth_bloc_test.dart
```

### Run with coverage

```bash
flutter test --coverage
```

---

## 📋 Quick Command Reference

| Task | Command |
|------|---------|
| **Code Gen** | `flutter pub run build_runner build --delete-conflicting-outputs` |
| **i18n** | `flutter gen-l10n` |
| **Clean** | `flutter clean && flutter pub get` |
| **Analyze** | `flutter analyze` |
| **Format** | `flutter format .` |
| **Test** | `flutter test` |
| **Run Dev** | `flutter run --dart-define=ENV=dev` |
| **Build APK Dev** | `flutter build apk --dart-define=ENV=dev` |
| **Build APK Prod** | `flutter build apk --release --dart-define=ENV=prod --split-debug-info=build/debug-symbols` |
| **Build AAB Prod** | `flutter build appbundle --release --dart-define=ENV=prod --split-debug-info=build/debug-symbols` |

---

## 🎯 Typical Workflow

```bash
# 1. Setup
flutter clean && flutter pub get

# 2. Code generation
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Generate localization
flutter gen-l10n

# 4. Run development
flutter run --dart-define=ENV=dev

# 5. Build for staging (test)
flutter build apk --release --dart-define=ENV=staging --split-debug-info=build/debug-symbols

# 6. Build for production
flutter build apk --release --dart-define=ENV=prod --split-debug-info=build/debug-symbols
```

---

## 📝 Notes

- **Environment Config**: Sử dụng `--dart-define=ENV=<env>` thay vì `--flavor`
- **Optimization**: Flags `--release`, `--split-debug-info` giúp giảm kích thước APK
- **Debug Symbols**: Bỏ debug symbols giúp giảm ~8-10MB
- **Minification**: Được enable tự động trong release mode (xem [`android/app/build.gradle.kts`](../android/app/build.gradle.kts))

---

## 🔗 Related Docs

- 📖 [Environment Setup](ENVIRONMENT_SETUP.md)
- 🏗️ [Architecture](architecture.md)
- 📱 [Setup Keystore](setup_keystore.md)
- 🚀 [CI/CD](cicd.md)
