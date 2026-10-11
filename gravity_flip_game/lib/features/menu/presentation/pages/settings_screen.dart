import 'package:flutter/material.dart';

import '../components/settings_slider.dart';
import '../components/toggle_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _musicVolume = 70;
  double _sfxVolume = 60;
  bool _vibrationEnabled = true;
  bool _soundEnabled = true;
  bool _showHints = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 8),
            ToggleButton(
              label: 'Sound Effects',
              value: _soundEnabled,
              icon: Icons.volume_up_rounded,
              onChanged: (value) => setState(() => _soundEnabled = value),
            ),
            const SizedBox(height: 12),
            ToggleButton(
              label: 'Vibration',
              value: _vibrationEnabled,
              icon: Icons.vibration_rounded,
              onChanged: (value) => setState(() => _vibrationEnabled = value),
            ),
            const SizedBox(height: 12),
            ToggleButton(
              label: 'Show hints',
              value: _showHints,
              icon: Icons.lightbulb_rounded,
              onChanged: (value) => setState(() => _showHints = value),
            ),
            const SizedBox(height: 18),
            SettingsSlider(
              title: 'Music Volume',
              value: _musicVolume,
              min: 0,
              max: 100,
              divisions: 10,
              subtitle: 'Controls background music and ambience.',
              onChanged: (value) => setState(() => _musicVolume = value),
            ),
            const SizedBox(height: 14),
            SettingsSlider(
              title: 'SFX Volume',
              value: _sfxVolume,
              min: 0,
              max: 100,
              divisions: 10,
              subtitle: 'Controls flips, bumps, and wins.',
              onChanged: (value) => setState(() => _sfxVolume = value),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings saved successfully.')),
                );
              },
              icon: const Icon(Icons.save_rounded),
              label: const Text('Save settings'),
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
  }
}
