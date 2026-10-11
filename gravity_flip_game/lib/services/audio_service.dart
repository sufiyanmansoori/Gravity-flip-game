import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playSfx(String asset) async {
    try {
      await _player.play(AssetSource(asset));
    } catch (_) {}
  }

  Future<void> playMusic(String asset, {bool loop = true}) async {
    try {
      await _player.setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.release);
      await _player.play(AssetSource(asset), volume: 0.6);
    } catch (_) {}
  }

  Future<void> stop() async {
    try { await _player.stop(); } catch (_) {}
  }
}
