import '../repositories/ads_repository.dart';

class ShowRewardedAdUseCase {
  const ShowRewardedAdUseCase(this.repository);

  final AdsRepository repository;

  Future<bool> call({String? adUnitId}) async {
    return repository.showRewardedAd(adUnitId: adUnitId);
  }
}
