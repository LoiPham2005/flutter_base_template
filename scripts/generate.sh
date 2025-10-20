#!/bin/bash

echo "🚀 Generating required files..."

# Chạy build_runner để tạo các file .g.dart, .freezed.dart, và .config.dart
flutter pub run build_runner build --delete-conflicting-outputs

echo "✅ Code generation completed successfully!"



# Build cho môi trường development
flutter build apk --flavor development -t lib/main_development.dart
flutter build appbundle --flavor development -t lib/main_development.dart

# Build cho môi trường production
flutter build apk --flavor production -t lib/main_production.dart