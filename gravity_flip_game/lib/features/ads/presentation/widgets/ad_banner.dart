import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({
    super.key,
    this.adUnitId,
    this.size = AdSize.banner,
    this.height = 60,
    this.margin,
  });

  final String? adUnitId;
  final AdSize size;
  final double height;
  final EdgeInsetsGeometry? margin;

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<void> _loadAd() async {
    final ad = BannerAd(
      adUnitId: widget.adUnitId ?? 'ca-app-pub-3940256099942544/6300978111',
      size: widget.size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _bannerAd = ad as BannerAd;
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) {
            setState(() {
              _isLoaded = false;
            });
          }
        },
      ),
    );

    await ad.load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return Container(
        alignment: Alignment.center,
        height: widget.height,
        margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const SizedBox(
          width: 120,
          height: 20,
          child: LinearProgressIndicator(minHeight: 4),
        ),
      );
    }

    return Container(
      height: widget.height,
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
