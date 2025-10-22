@echo off
echo Running build_runner...
flutter pub run build_runner build --delete-conflicting-outputs
echo ✅ Code generation completed!

echo Generating l10n...
flutter gen-l10n
echo ✅ L10n generated!

echo Building APK...
flutter build apk --flavor development -t lib/main_development.dart
flutter build apk --flavor staging -t lib/main_staging.dart
flutter build apk --flavor production -t lib/main_production.dart
echo ✅ APK built!

echo Building AAB...
flutter build appbundle --flavor production -t lib/main_production.dart
echo ✅ AAB built!
pause
