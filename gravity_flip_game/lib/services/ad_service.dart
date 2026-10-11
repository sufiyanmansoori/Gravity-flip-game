import 'dart:async';

import 'package:flutter/foundation.dart'
    show kIsWeb; // <--- Yeh line add karein
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static const androidAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const interstitialUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static const rewardedUnitId = 'ca-app-pub-3940256099942544/5224354917';

  static int runsSinceLastAd = 0;
  static RewardedAd? _rewardedAd;
  static bool _rewardedReady = false;

  static bool get rewardedReady => _rewardedReady;

  static Future<void> initialize() async {
    // Web par ads initialize mat karo, warna crash hoga
    if (kIsWeb) {
      return;
    }

    await MobileAds.instance.initialize();
    await loadRewardedAd();
  }

  static bool shouldShowInterstitial() {
    return runsSinceLastAd > 0 && runsSinceLastAd % 3 == 0;
  }

  static void recordRun() {
    runsSinceLastAd += 1;
  }

  static Future<void> loadRewardedAd() async {
    // Web par ad load mat karo
    if (kIsWeb) return;

    await RewardedAd.load(
      adUnitId: rewardedUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _rewardedReady = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedReady = false;
          _rewardedAd = null;
        },
      ),
    );
  }

  static Future<bool> showRewardedRevive() async {
    // Web par ad show mat karo
    if (kIsWeb) return false;

    if (_rewardedAd == null) {
      await loadRewardedAd();
    }

    final ad = _rewardedAd;
    if (ad == null) {
      return false;
    }

    final completer = Completer<bool>();

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd displayedAd) {
        displayedAd.dispose();
        _rewardedAd = null;
        loadRewardedAd();
        completer.complete(true);
      },
      onAdFailedToShowFullScreenContent:
          (RewardedAd displayedAd, AdError error) {
            displayedAd.dispose();
            _rewardedAd = null;
            completer.complete(false);
          },
    );

    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {});

    return completer.future;
  }
}
