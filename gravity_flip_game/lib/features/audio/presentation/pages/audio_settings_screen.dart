import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_bloc.dart';
import '../components/audio_toggle.dart';
import '../components/audio_volume_slider.dart';

class AudioSettingsScreen extends StatelessWidget {
  const AudioSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final settings = state.settings;

        return Scaffold(
          appBar: AppBar(title: const Text('Audio Settings')),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 12),
                AudioToggle(
                  label: 'Master audio',
                  value: settings.masterEnabled,
                  icon: Icons.volume_up_rounded,
                  onChanged: (value) {
                    context.read<AudioBloc>().add(
                      AudioSettingsChanged(masterEnabled: value),
                    );
                  },
                ),
                const SizedBox(height: 12),
                AudioToggle(
                  label: 'Music',
                  value: settings.musicEnabled,
                  icon: Icons.music_note_rounded,
                  onChanged: (value) {
                    context.read<AudioBloc>().add(
                      AudioSettingsChanged(musicEnabled: value),
                    );
                  },
                ),
                const SizedBox(height: 12),
                AudioToggle(
                  label: 'Sound effects',
                  value: settings.sfxEnabled,
                  icon: Icons.spatial_audio_rounded,
                  onChanged: (value) {
                    context.read<AudioBloc>().add(
                      AudioSettingsChanged(sfxEnabled: value),
                    );
                  },
                ),
                const SizedBox(height: 18),
                AudioVolumeSlider(
                  title: 'Music volume',
                  value: settings.musicVolume,
                  icon: Icons.queue_music_rounded,
                  subtitle:
                      'Background music intensity for menus and gameplay.',
                  onChanged: (value) {
                    context.read<AudioBloc>().add(
                      AudioSettingsChanged(musicVolume: value),
                    );
                  },
                ),
                const SizedBox(height: 14),
                AudioVolumeSlider(
                  title: 'SFX volume',
                  value: settings.sfxVolume,
                  icon: Icons.graphic_eq_rounded,
                  subtitle: 'Jump, collect, and hit effects.',
                  onChanged: (value) {
                    context.read<AudioBloc>().add(
                      AudioSettingsChanged(sfxVolume: value),
                    );
                  },
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () {
                    context.read<AudioBloc>().add(const AudioInitialized());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Audio settings saved.')),
                    );
                  },
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Save changes'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
