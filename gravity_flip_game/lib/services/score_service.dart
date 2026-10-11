import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {
  static const _bestKey = 'gravity_flip_best';

  Future<int> getBest() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_bestKey) ?? 0;
  }

  Future<void> setBest(int v) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_bestKey, v);
  }
}
