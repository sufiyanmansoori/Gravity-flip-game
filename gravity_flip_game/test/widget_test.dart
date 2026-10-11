import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_flip_game/game/level_generator.dart';
import 'package:gravity_flip_game/main.dart';
import 'package:gravity_flip_game/services/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Gravity Flip app loads splash screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('GRAVITY FLIP'), findsOneWidget);
    expect(find.text('G'), findsOneWidget);
  });

  test('Level generator creates six worlds with 20 levels each', () {
    final worlds = LevelGenerator.generateWorlds();

    expect(worlds.length, 6);
    expect(worlds.first.totalLevels, 20);
    final level = LevelGenerator.generateLevel(3, 12);
    expect(level.worldIndex, 3);
    expect(level.levelNumber, 12);
    expect(level.baseSpeed, greaterThan(0));
  });

  test('Settings service loads and saves configuration', () async {
    SharedPreferences.setMockInitialValues({});

    final service = SettingsService();
    const settings = GameSettings(
      musicEnabled: false,
      vibrationEnabled: false,
      reducedMotion: true,
      graphicsQuality: 0.6,
    );

    await service.save(settings);
    final loaded = await service.load();

    expect(loaded.musicEnabled, isFalse);
    expect(loaded.vibrationEnabled, isFalse);
    expect(loaded.reducedMotion, isTrue);
    expect(loaded.graphicsQuality, 0.6);
  });
}
