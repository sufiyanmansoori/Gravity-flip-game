import '../repositories/ads_repository.dart';

class ShowInterstitialAdUseCase {
  const ShowInterstitialAdUseCase(this.repository);

  final AdsRepository repository;

  Future<bool> call({String? adUnitId}) async {
    return repository.showInterstitialAd(adUnitId: adUnitId);
  }
}
