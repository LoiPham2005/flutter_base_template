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

Build APK for each environment using flavors:

### Development

```bash
flutter build apk --flavor development -t lib/main.dart
```

### Staging

```bash
flutter build apk --flavor staging -t lib/main.dart
```

### Production

```bash
flutter build apk --flavor production -t lib/main.dart
```

**Output location:** `build/app/outputs/flutter-apk/`

---

## 5. Build AAB (App Bundle - For Google Play, With Flavors)

Build Android App Bundle for each environment:

### Development

```bash
flutter build appbundle --flavor development -t lib/main.dart
```

### Staging

```bash
flutter build appbundle --flavor staging -t lib/main.dart
```

### Production

```bash
flutter build appbundle --flavor production -t lib/main.dart
```

**Output location:** `build/app/outputs/bundle/<flavor>/`

---

## 6. Build iOS (With Flavors)

### Development

```bash
flutter build ios --flavor development -t lib/main.dart
```

### Staging

```bash
flutter build ios --flavor staging -t lib/main.dart
```

### Production

```bash
flutter build ios --flavor production -t lib/main.dart
```

---

## 7. Run on Device/Emulator (With Flavors)

### Development

```bash
flutter run --flavor development -t lib/main.dart
```

### Staging

```bash
flutter run --flavor staging -t lib/main.dart
```

### Production

```bash
flutter run --flavor production -t lib/main.dart
```

---

## 8. (Optional) Kết hợp --dart-define nếu cần truyền ENV cho code Dart

```bash
flutter run --flavor development -t lib/main.dart --dart-define=ENV=dev
flutter run --flavor staging -t lib/main.dart --dart-define=ENV=staging
flutter run --flavor production -t lib/main.dart --dart-define=ENV=prod
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
# 1. Setup
flutter clean && flutter pub get

# 2. Code generation
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Generate localization
flutter gen-l10n

# 4. Run development
flutter run --flavor development -t lib/main.dart

# 5. Build for staging (test)
flutter build apk --flavor staging -t lib/main.dart

# 6. Build for production
flutter build apk --flavor production -t lib/main.dart
```

---

## 📝 Notes

- **Flavors**: Đảm bảo đã cấu hình productFlavors trong `android/app/build.gradle.kts` và scheme/target trên iOS.
- **Entrypoint**: Nếu bạn có file main riêng cho từng flavor, thay `lib/main.dart` bằng file tương ứng.
- **Kết hợp --dart-define**: Nếu code Dart cần biết ENV, truyền thêm `--dart-define=ENV=...`.
- **Output**: APK/AAB sẽ nằm trong thư mục `build/app/outputs/`.

---

## 🔗 Related Docs

- 📖 [Environment Setup](ENVIRONMENT_SETUP.md)
- 🏗️ [Architecture](architecture.md)
- 📱 [Setup Keystore](setup_keystore.md)
- 🚀 [CI/CD](cicd.md)