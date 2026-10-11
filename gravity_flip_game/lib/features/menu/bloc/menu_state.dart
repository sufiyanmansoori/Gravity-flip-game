part of 'menu_bloc.dart';

class MenuState extends Equatable {
  const MenuState({
    this.currentScreen = 'main',
    this.isPaused = false,
    this.musicVolume = 70,
    this.sfxVolume = 60,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.showHints = true,
  });

  final String currentScreen;
  final bool isPaused;
  final double musicVolume;
  final double sfxVolume;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final bool showHints;

  MenuState copyWith({
    String? currentScreen,
    bool? isPaused,
    double? musicVolume,
    double? sfxVolume,
    bool? soundEnabled,
    bool? vibrationEnabled,
    bool? showHints,
  }) {
    return MenuState(
      currentScreen: currentScreen ?? this.currentScreen,
      isPaused: isPaused ?? this.isPaused,
      musicVolume: musicVolume ?? this.musicVolume,
      sfxVolume: sfxVolume ?? this.sfxVolume,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      showHints: showHints ?? this.showHints,
    );
  }

  @override
  List<Object?> get props => [
    currentScreen,
    isPaused,
    musicVolume,
    sfxVolume,
    soundEnabled,
    vibrationEnabled,
    showHints,
  ];
}
