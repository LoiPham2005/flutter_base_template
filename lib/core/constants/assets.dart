// // lib/core/constants/asset_constants.dart
// class AssetConstants {
//   AssetConstants._();
  
//   // Images
//   static const String logo = 'assets/images/logo.png';
//   static const String placeholder = 'assets/images/placeholder.jpg';
//   static const String noData = 'assets/images/no_data.png';
  
//   // Icons
//   static const String iconHome = 'assets/icons/home.svg';
//   static const String iconProfile = 'assets/icons/profile.svg';
  
//   // Animations (Lottie)
//   static const String loadingAnimation = 'assets/animations/loading.json';
//   static const String successAnimation = 'assets/animations/success.json';
//   static const String errorAnimation = 'assets/animations/error.json';
// }


// lib/core/constants/assets.dart
class Assets {
  Assets._();

  static _Images get images => _Images();
  static _Icons get icons => _Icons();
  static _Animations get animations => _Animations();
}

class _Images {
  final String logo = 'assets/images/logo.png';
  final String placeholder = 'assets/images/placeholder.jpg';
  final String noData = 'assets/images/no_data.png';
}

class _Icons {
  final String home = 'assets/icons/home.svg';
  final String profile = 'assets/icons/profile.svg';
  final String search = 'assets/icons/search.svg';
  final String cart = 'assets/icons/cart.svg';
  final String settings = 'assets/icons/settings.svg';
}

class _Animations {
  final String loading = 'assets/animations/loading.json';
  final String success = 'assets/animations/success.json';
  final String error = 'assets/animations/error.json';
}
