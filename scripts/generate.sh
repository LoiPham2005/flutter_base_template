#!/bin/bash

echo "🚀 Generating required files..."

# Chạy build_runner để tạo các file .g.dart, .freezed.dart, và .config.dart
flutter pub run build_runner build --delete-conflicting-outputs

echo "✅ Code generation completed successfully!"



# Build APK
flutter build apk --flavor development -t lib/main_development.dart
flutter build apk --flavor staging -t lib/main_staging.dart
flutter build apk --flavor production -t lib/main_production.dart

# Build AAB
flutter build appbundle --flavor production -t lib/main_production.dart