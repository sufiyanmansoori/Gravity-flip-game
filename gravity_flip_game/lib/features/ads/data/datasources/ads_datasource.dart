import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsDataSource {
  const AdsDataSource();

  static const String defaultBannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';
  static const String defaultInterstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';
  static const String defaultRewardedAdUnitId =
      'ca-app-pub-3940256099942544/5224354917';

  Future<void> initialize() async {
    if (kIsWeb) {
      return;
    }

    await MobileAds.instance.initialize();
  }

  Future<BannerAd> loadBannerAd({
    String? adUnitId,
    AdSize size = AdSize.banner,
  }) async {
    final bannerAd = BannerAd(
      adUnitId: adUnitId ?? defaultBannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    await bannerAd.load();
    return bannerAd;
  }

  Future<bool> showInterstitialAd({String? adUnitId}) async {
    if (kIsWeb) {
      return false;
    }

    final completer = Completer<bool>();

    InterstitialAd.load(
      adUnitId: adUnitId ?? defaultInterstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd dismissed) {
              dismissed.dispose();
              completer.complete(true);
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd failedAd, AdError error) {
                  failedAd.dispose();
                  completer.complete(false);
                },
          );

          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          completer.complete(false);
        },
      ),
    );

    return completer.future;
  }

  Future<bool> showRewardedAd({String? adUnitId}) async {
    if (kIsWeb) {
      return false;
    }

    final completer = Completer<bool>();

    RewardedAd.load(
      adUnitId: adUnitId ?? defaultRewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (AdWithoutView dismissed) {
              completer.complete(true);
            },
            onAdFailedToShowFullScreenContent:
                (AdWithoutView failedAd, AdError error) {
                  completer.complete(false);
                },
          );

          ad.show(onUserEarnedReward: (_, _) {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          completer.complete(false);
        },
      ),
    );

    return completer.future;
  }
}
