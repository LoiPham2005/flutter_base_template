# Tạo thư mục .github\workflows\build.yml

# copy vào file build.yml

name: Build and Deploy

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '11'
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.5'
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Run code generation
        run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Run tests
        run: flutter test
      
      - name: Build APK
        run: flutter build apk --release --flavor production -t lib/main_production.dart
      
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-production-release.apk

  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.5'
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Run code generation
        run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Run tests
        run: flutter test
      
      - name: Build iOS
        run: flutter build ios --release --no-codesign --flavor production -t lib/main_production.dart