import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdsRepository {
  Future<void> initialize();

  Future<BannerAd> loadBannerAd({
    String? adUnitId,
    AdSize size = AdSize.banner,
  });

  Future<bool> showInterstitialAd({String? adUnitId});

  Future<bool> showRewardedAd({String? adUnitId});
}
