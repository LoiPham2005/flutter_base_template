# 🚀 Flutter Build & Code Generation Commands (With Flavors)

## 1. Code Generation (Build Runner)

Generate `.g.dart`, `.freezed.dart`, `.config.dart` files:

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## 2. Generate Localization (i18n)

Generate localization files from `.arb`:

```bash
flutter gen-l10n
```

---

## 3. Clean Project

Remove build artifacts and regenerate:

```bash
flutter clean
flutter pub get
```

---

## 4. Build APK (With Flavors)

Build APK for each environment using flavors **và entrypoint riêng**:

### Development

```bash
flutter build apk --flavor development -t lib/main_dev.dart
```

### Staging

```bash
flutter build apk --flavor staging -t lib/main_stg.dart
```

### Production

```bash
flutter build apk --flavor production -t lib/main_prod.dart
```

**Output location:** `build/app/outputs/flutter-apk/`

---

## 5. Build AAB (App Bundle - For Google Play, With Flavors)

Build Android App Bundle cho từng môi trường:

### Development

```bash
flutter build appbundle --flavor development -t lib/main_dev.dart
```

### Staging

```bash
flutter build appbundle --flavor staging -t lib/main_stg.dart
```

### Production

```bash
flutter build appbundle --flavor production -t lib/main_prod.dart
```

**Output location:** `build/app/outputs/bundle/<flavor>/`

---

## 6. Build iOS (With Flavors)

### Development

```bash
flutter build ios --flavor development -t lib/main_dev.dart
```

### Staging

```bash
flutter build ios --flavor staging -t lib/main_stg.dart
```

### Production

```bash
flutter build ios --flavor production -t lib/main_prod.dart
```

---

## 7. Run on Device/Emulator (With Flavors)

### Development

```bash
flutter run --flavor development -t lib/main_dev.dart
```

### Staging

```bash
flutter run --flavor staging -t lib/main_stg.dart
```

### Production

```bash
flutter run --flavor production -t lib/main_prod.dart
```

---

## 8. (Optional) Kết hợp --dart-define nếu cần truyền ENV cho code Dart

```bash
flutter run --flavor development -t lib/main_dev.dart --dart-define=ENV=dev
flutter run --flavor staging -t lib/main_stg.dart --dart-define=ENV=staging
flutter run --flavor production -t lib/main_prod.dart --dart-define=ENV=prod
```

---

## 9. Upgrade Dependencies

Check and upgrade packages:

```bash
flutter pub upgrade
flutter pub outdated
```

---

## 10. Code Analysis & Formatting

### Analyze code for errors

```bash
flutter analyze
```

### Format code (Dart style)

```bash
flutter format .
```

---

## 11. Run Tests

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

| Task                | Command Example |
|---------------------|----------------|
| **Build APK Dev**   | `flutter build apk --flavor development -t lib/main_dev.dart` |
| **Build APK Stg**   | `flutter build apk --flavor staging -t lib/main_stg.dart` |
| **Build APK Prod**  | `flutter build apk --flavor production -t lib/main_prod.dart` |
| **Build AAB Dev**   | `flutter build appbundle --flavor development -t lib/main_dev.dart` |
| **Build AAB Stg**   | `flutter build appbundle --flavor staging -t lib/main_stg.dart` |
| **Build AAB Prod**  | `flutter build appbundle --flavor production -t lib/main_prod.dart` |
| **Run Dev**         | `flutter run --flavor development -t lib/main_dev.dart` |
| **Run Stg**         | `flutter run --flavor staging -t lib/main_stg.dart` |
| **Run Prod**        | `flutter run --flavor production -t lib/main_prod.dart` |
| **Code Gen**        | `flutter pub run build_runner build --delete-conflicting-outputs` |
| **i18n**            | `flutter gen-l10n` |
| **Clean**           | `flutter clean && flutter pub get` |
| **Analyze**         | `flutter analyze` |
| **Format**          | `flutter format .` |
| **Test**            | `flutter test` |

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
flutter run --flavor development -t lib/main_dev.dart

# 5. Build for staging (test)
flutter build apk --flavor staging -t lib/main_stg.dart

# 6. Build for production
flutter build apk --flavor production -t lib/main_prod.dart
```

---

## 📝 Notes

- **Flavors**: Đảm bảo đã cấu hình productFlavors trong `android/app/build.gradle.kts` và scheme/target trên iOS.
- **Entrypoint**: Sử dụng file main riêng cho từng flavor: `main_dev.dart`, `main_stg.dart`, `main_prod.dart`.
- **Kết hợp --dart-define**: Nếu code Dart cần biết ENV, truyền thêm `--dart-define=ENV=...`.
- **Output**: APK/AAB sẽ nằm trong thư mục `build/app/outputs/`.

---

## 🔗 Related Docs

- 📖 [Environment Setup](ENVIRONMENT_SETUP.md)
- 🏗️ [Architecture](architecture.md)
- 📱 [Setup Keystore](setup_keystore.md)
- 🚀 [CI/CD](cicd.md)
