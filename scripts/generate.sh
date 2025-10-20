#!/bin/bash

echo "🚀 Generating required files..."

# Chạy build_runner để tạo các file .g.dart, .freezed.dart, và .config.dart
flutter pub run build_runner build --delete-conflicting-outputs

echo "✅ Code generation completed successfully!"