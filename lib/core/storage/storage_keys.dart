// Xóa các phương thức và chỉ giữ lại các hằng số key
class StorageKeys {
  StorageKeys._(); // Private constructor để không ai có thể tạo instance

  // Auth
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userProfile = 'user_profile';
  static const String isLogin = 'is_login';

  // App Settings
  static const String isFirstRun = 'is_first_run';
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
}