import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../domain/repositories/ads_repository.dart';
import '../datasources/ads_datasource.dart';

class AdsRepositoryImpl implements AdsRepository {
  AdsRepositoryImpl({required this.dataSource});

  final AdsDataSource dataSource;

  @override
  Future<void> initialize() => dataSource.initialize();

  @override
  Future<BannerAd> loadBannerAd({
    String? adUnitId,
    AdSize size = AdSize.banner,
  }) => dataSource.loadBannerAd(adUnitId: adUnitId, size: size);

  @override
  Future<bool> showInterstitialAd({String? adUnitId}) async {
    return dataSource.showInterstitialAd(adUnitId: adUnitId);
  }

  @override
  Future<bool> showRewardedAd({String? adUnitId}) async {
    return dataSource.showRewardedAd(adUnitId: adUnitId);
  }
}
