// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdMobService {
//   static final AdMobService _instance = AdMobService._internal();
//   factory AdMobService() => _instance;
//   AdMobService._internal();

//   Future<void> init() async {
//     await MobileAds.instance.initialize();
//   }

//   // Banner Ad Test
//   BannerAd createBannerAd() {
//     return BannerAd(
//       adUnitId: BannerAd.testAdUnitId, // ID test Google
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (_) => print('Banner loaded'),
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//           print('Banner failed: $error');
//         },
//       ),
//       request: const AdRequest(),
//     );
//   }

//   // Interstitial Ad Test
//   Future<InterstitialAd?> loadInterstitialAd() async {
//     InterstitialAd? interstitial;
//     await InterstitialAd.load(
//       adUnitId: InterstitialAd.testAdUnitId, // ID test Google
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) => interstitial = ad,
//         onAdFailedToLoad: (error) => print('Interstitial failed: $error'),
//       ),
//     );
//     return interstitial;
//   }

//   // Rewarded Ad Test
//   Future<RewardedAd?> loadRewardedAd() async {
//     RewardedAd? rewarded;
//     await RewardedAd.load(
//       adUnitId: RewardedAd.testAdUnitId, // ID test Google
//       request: const AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (ad) => rewarded = ad,
//         onAdFailedToLoad: (error) => print('Rewarded failed: $error'),
//       ),
//     );
//     return rewarded;
//   }
// }
