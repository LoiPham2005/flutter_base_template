# Flutter Build & Code Generation Commands

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
flutter build apk --flavor development --dart-define=ENV=dev -t lib/main.dart

# Staging
flutter build apk --flavor staging --dart-define=ENV=stg -t lib/main.dart

# Production
flutter build apk --flavor production --dart-define=ENV=prod -t lib/main.dart
```

## 5. Build AAB (App Bundle)

```bash
# Production AAB
flutter build appbundle --flavor production --dart-define=ENV=prod -t lib/main.dart

```

## 6. Chạy ứng dụng trên thiết bị/emulator

```bash
# Development
flutter run --flavor development --dart-define=ENV=dev -t lib/main.dart

# Staging
flutter run --flavor staging --dart-define=ENV=stg -t lib/main.dart

# Production
flutter run --flavor production --dart-define=ENV=prod -t lib/main.dart
```

## 7. Build cho iOS

```bash
# Development
flutter build ios --flavor development --dart-define=ENV=dev -t lib/main.dart

# Staging
flutter build ios --flavor staging --dart-define=ENV=stg -t lib/main.dart

# Production
flutter build ios --flavor production --dart-define=ENV=prod -t lib/main.dart
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
```
