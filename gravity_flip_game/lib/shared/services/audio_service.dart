import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService() : _player = AudioPlayer();

  final AudioPlayer _player;

  Future<void> playAsset(String assetPath, {bool loop = false}) async {
    await _player.play(AssetSource(assetPath), mode: PlayerMode.mediaPlayer);
    if (loop) {
      await _player.setReleaseMode(ReleaseMode.loop);
    }
  }

  Future<void> playUrl(String url) async {
    await _player.play(UrlSource(url));
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
