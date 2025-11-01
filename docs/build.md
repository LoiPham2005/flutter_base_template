<!-- # Flutter Build & Code Generation Commands

## 1. Tạo các file .g.dart, .freezed.dart, .config.dart

```bash
flutter pub run build_runner build --delete-conflicting-outputs
# hoặc nếu muốn watch thay đổi liên tục
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 2. Generate localization

```bash
flutter gen-l10n
```

## 3. Clean project (xóa build cũ)

```bash
flutter clean
flutter pub get
```

## 4. Build APK

```bash
# Development
flutter build apk --flavor development -t lib/main_development.dart

# Staging
flutter build apk --flavor staging -t lib/main_staging.dart

# Production
flutter build apk --flavor production -t lib/main_production.dart
```

## 5. Build AAB (App Bundle)

```bash
# Production AAB
flutter build appbundle --flavor production -t lib/main_production.dart
```

## 6. Chạy ứng dụng trên thiết bị/emulator

```bash
# Chạy development
flutter run --flavor development -t lib/main_development.dart

# Chạy staging
flutter run --flavor staging -t lib/main_staging.dart

# Chạy production
flutter run --flavor production -t lib/main_production.dart
```

## 7. Build cho iOS

```bash
# Development
flutter build ios --flavor development -t lib/main_development.dart

# Staging
flutter build ios --flavor staging -t lib/main_staging.dart

# Production
flutter build ios --flavor production -t lib/main_production.dart
```

## 8. Upgrade packages

```bash
flutter pub upgrade
flutter pub outdated
```

## 9. Analyze & Format code

```bash
flutter analyze
flutter format .
```

## 10. Test

```bash
flutter test
``` -->
