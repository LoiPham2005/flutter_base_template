// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:flutter_base_project/widgets/image_details.dart';

// enum TemplateType { small, medium }

// class AdMobService {
//   AdMobService._privateConstructor();
//   static final AdMobService instance = AdMobService._privateConstructor();

//   // ------------------------- Ad Units -------------------------
//   // Test Ad Unit IDs
//   static final Map<String, String> _testAdUnitIds = {
//     'android_banner': 'ca-app-pub-3940256099942544/6300978111',
//     'ios_banner': 'ca-app-pub-3940256099942544/2934735716',
//     'android_interstitial': 'ca-app-pub-3940256099942544/1033173712',
//     'ios_interstitial': 'ca-app-pub-3940256099942544/4411468910',
//     'android_rewarded': 'ca-app-pub-3940256099942544/5224354917',
//     'ios_rewarded': 'ca-app-pub-3940256099942544/1712485313',
//     'android_native': 'ca-app-pub-3940256099942544/2247696110',
//     'ios_native': 'ca-app-pub-3940256099942544/3986624511',
//     'android_app_open': 'ca-app-pub-3940256099942544/9257395921',
//     'ios_app_open': 'ca-app-pub-3940256099942544/5662855259',
//   };

//   // Production Ad Unit IDs - Replace with your own IDs
//   static final Map<String, String> _prodAdUnitIds = {
//     'android_banner': 'YOUR_ANDROID_BANNER_AD_UNIT_ID',
//     'ios_banner': 'YOUR_IOS_BANNER_AD_UNIT_ID',
//     'android_interstitial': 'YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID',
//     'ios_interstitial': 'YOUR_IOS_INTERSTITIAL_AD_UNIT_ID',
//     'android_rewarded': 'YOUR_ANDROID_REWARDED_AD_UNIT_ID',
//     'ios_rewarded': 'YOUR_IOS_REWARDED_AD_UNIT_ID',
//     'android_native': 'YOUR_ANDROID_NATIVE_AD_UNIT_ID',
//     'ios_native': 'YOUR_IOS_NATIVE_AD_UNIT_ID',
//     'android_app_open': 'YOUR_ANDROID_APP_OPEN_AD_UNIT_ID',
//     'ios_app_open': 'YOUR_IOS_APP_OPEN_AD_UNIT_ID',
//   };

//   String _getAdUnitId(String key) {
//     if (kDebugMode) return _testAdUnitIds[key]!;
//     return _prodAdUnitIds[key]!;
//   }

//   String get bannerAdUnitId => _getAdUnitId('android_banner',);
//   String get interstitialAdUnitId => _getAdUnitId('android_interstitial');
//   String get rewardedAdUnitId => _getAdUnitId('android_rewarded');
//   String get nativeAdUnitId => _getAdUnitId('android_native');
//   String get appOpenAdUnitId => _getAdUnitId('android_app_open');

//   // ------------------------- Global Ad Instances -------------------------
//   InterstitialAd? _interstitialAd;
//   RewardedAd? _rewardedAd;
//   AppOpenAd? _appOpenAd;

//   bool _isInterstitialReady = false;
//   bool _isRewardedReady = false;
//   bool _isAppOpenReady = false;

//   bool get isInterstitialReady => _isInterstitialReady;
//   bool get isRewardedReady => _isRewardedReady;
//   bool get isAppOpenReady => _isAppOpenReady;

//   // ------------------------- Generic Ad Loader -------------------------
//   Future<T?> _loadAd<T>({
//     required String adUnitId,
//     required FutureOr<T> Function()? loader,
//     Duration timeout = const Duration(seconds: 15),
//   }) async {
//     final Completer<T?> completer = Completer<T?>();
//     try {
//       final result = await loader?.call();
//       completer.complete(result);
//     } catch (e) {
//       debugPrint('Ad load failed: $e');
//       completer.complete(null);
//     }
//     // Timeout safety
//     Timer(timeout, () {
//       if (!completer.isCompleted) {
//         debugPrint('Ad loading timed out');
//         completer.complete(null);
//       }
//     });
//     return completer.future;
//   }

//   // ------------------------- Interstitial -------------------------
//   Future<void> loadInterstitialAd() async {
//     _interstitialAd = await _loadAd<InterstitialAd>(
//       adUnitId: interstitialAdUnitId,
//       loader: () async {
//         final completer = Completer<InterstitialAd>();
//         InterstitialAd.load(
//           adUnitId: interstitialAdUnitId,
//           request: const AdRequest(),
//           adLoadCallback: InterstitialAdLoadCallback(
//             onAdLoaded: (ad) {
//               _isInterstitialReady = true;
//               completer.complete(ad);
//             },
//             onAdFailedToLoad: (error) {
//               _isInterstitialReady = false;
//               completer.completeError(error);
//             },
//           ),
//         );
//         return completer.future;
//       },
//     );
//   }

//   Future<bool> showInterstitialAd() async {
//     if (_interstitialAd == null) return false;
//     final ad = _interstitialAd!;
//     final completer = Completer<bool>();

//     ad.fullScreenContentCallback = FullScreenContentCallback(
//       onAdDismissedFullScreenContent: (ad) {
//         _interstitialAd = null;
//         _isInterstitialReady = false;
//         loadInterstitialAd(); // preload next
//         completer.complete(true);
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         _interstitialAd = null;
//         _isInterstitialReady = false;
//         completer.complete(false);
//       },
//     );

//     ad.show();
//     return completer.future;
//   }

//   // ------------------------- Rewarded -------------------------
//   Future<void> loadRewardedAd() async {
//     _rewardedAd = await _loadAd<RewardedAd>(
//       adUnitId: rewardedAdUnitId,
//       loader: () async {
//         final completer = Completer<RewardedAd>();
//         RewardedAd.load(
//           adUnitId: rewardedAdUnitId,
//           request: const AdRequest(),
//           rewardedAdLoadCallback: RewardedAdLoadCallback(
//             onAdLoaded: (ad) {
//               _isRewardedReady = true;
//               completer.complete(ad);
//             },
//             onAdFailedToLoad: (error) {
//               _isRewardedReady = false;
//               completer.completeError(error);
//             },
//           ),
//         );
//         return completer.future;
//       },
//     );
//   }

//   Future<bool> showRewardedAd({required VoidCallback onReward}) async {
//     if (_rewardedAd == null) return false;
//     final ad = _rewardedAd!;
//     final completer = Completer<bool>();

//     ad.fullScreenContentCallback = FullScreenContentCallback(
//       onAdDismissedFullScreenContent: (ad) {
//         _rewardedAd = null;
//         _isRewardedReady = false;
//         loadRewardedAd();
//         completer.complete(false);
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         _rewardedAd = null;
//         _isRewardedReady = false;
//         completer.complete(false);
//       },
//     );

//     ad.show(onUserEarnedReward: (ad, reward) {
//       onReward();
//     });

//     return completer.future;
//   }

//   // ------------------------- App Open -------------------------
//   Future<void> loadAppOpenAd() async {
//     _appOpenAd = await _loadAd<AppOpenAd>(
//       adUnitId: appOpenAdUnitId,
//       loader: () async {
//         final completer = Completer<AppOpenAd>();
//         AppOpenAd.load(
//           adUnitId: appOpenAdUnitId,
//           request: const AdRequest(),
//           adLoadCallback: AppOpenAdLoadCallback(
//             onAdLoaded: (ad) {
//               _isAppOpenReady = true;
//               completer.complete(ad);
//             },
//             onAdFailedToLoad: (error) {
//               _isAppOpenReady = false;
//               completer.completeError(error);
//             },
//           ),
//         );
//         return completer.future;
//       },
//     );
//   }

//   Future<void> showAppOpenAd() async {
//     if (_appOpenAd == null) return;
//     final ad = _appOpenAd!;
//     ad.show();
//     _appOpenAd = null;
//     _isAppOpenReady = false;
//     loadAppOpenAd(); // preload next
//   }

//   // ------------------------- Banner -------------------------
//   BannerAd createBannerAd(AdSize size) {
//     return BannerAd(
//       adUnitId: bannerAdUnitId,
//       size: size,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (_) => debugPrint('Banner loaded'),
//         onAdFailedToLoad: (ad, err) {
//           debugPrint('Banner failed: ${err.message}');
//           ad.dispose();
//         },
//       ),
//     );
//   }

//   // ------------------------- Navigation with Interstitial -------------------------
//   Future<void> navigateToImageDetailsWithAd({
//     required BuildContext context,
//     required String id,
//     required String imageUrl,
//     required bool isFavorite,
//   }) async {
//     if (isInterstitialReady) await showInterstitialAd();
//     if (!context.mounted) return;
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ImageDetails(
//           id: id,
//           imageUrl: imageUrl,
//           isFavorite: isFavorite,
//         ),
//       ),
//     );
//   }
// }
