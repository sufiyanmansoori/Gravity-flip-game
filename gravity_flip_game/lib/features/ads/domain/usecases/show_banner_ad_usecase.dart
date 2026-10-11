import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../repositories/ads_repository.dart';

class ShowBannerAdUseCase {
  const ShowBannerAdUseCase(this.repository);

  final AdsRepository repository;

  Future<BannerAd> call({String? adUnitId, AdSize size = AdSize.banner}) async {
    return repository.loadBannerAd(adUnitId: adUnitId, size: size);
  }
}
