part of 'menu_bloc.dart';

abstract class MenuEvent {
  const MenuEvent();
}

class LoadMenu extends MenuEvent {
  const LoadMenu();
}

class NavigateToScreen extends MenuEvent {
  const NavigateToScreen(this.screen);

  final String screen;
}

class TogglePauseMenu extends MenuEvent {
  const TogglePauseMenu(this.isPaused);

  final bool isPaused;
}

class UpdateSettings extends MenuEvent {
  const UpdateSettings({
    this.musicVolume,
    this.sfxVolume,
    this.soundEnabled,
    this.vibrationEnabled,
    this.showHints,
  });

  final double? musicVolume;
  final double? sfxVolume;
  final bool? soundEnabled;
  final bool? vibrationEnabled;
  final bool? showHints;
}
