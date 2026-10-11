import 'package:flutter/material.dart';

import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService();
  GameSettings _settings = const GameSettings();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _settingsService.load();
    if (!mounted) return;
    setState(() {
      _settings = settings;
      _loading = false;
    });
  }

  Future<void> _saveSettings() async {
    await _settingsService.save(_settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF090D18), Color(0xFF141D31)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'SETTINGS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _ToggleRow(
                        label: 'Music',
                        value: _settings.musicEnabled,
                        onChanged: (value) {
                          setState(
                            () => _settings = _settings.copyWith(
                              musicEnabled: value,
                            ),
                          );
                          _saveSettings();
                        },
                      ),
                      _ToggleRow(
                        label: 'Sound Effects',
                        value: _settings.soundEnabled,
                        onChanged: (value) {
                          setState(
                            () => _settings = _settings.copyWith(
                              soundEnabled: value,
                            ),
                          );
                          _saveSettings();
                        },
                      ),
                      _ToggleRow(
                        label: 'Vibration',
                        value: _settings.vibrationEnabled,
                        onChanged: (value) {
                          setState(
                            () => _settings = _settings.copyWith(
                              vibrationEnabled: value,
                            ),
                          );
                          _saveSettings();
                        },
                      ),
                      _ToggleRow(
                        label: 'Reduced Motion',
                        value: _settings.reducedMotion,
                        onChanged: (value) {
                          setState(
                            () => _settings = _settings.copyWith(
                              reducedMotion: value,
                            ),
                          );
                          _saveSettings();
                        },
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Graphics Quality',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF6C4BFF),
                          thumbColor: const Color(0xFF00D2FF),
                          overlayColor: const Color(0xFF6C4BFF).withAlpha(100),
                        ),
                        child: Slider(
                          value: _settings.graphicsQuality,
                          onChanged: (value) {
                            setState(
                              () => _settings = _settings.copyWith(
                                graphicsQuality: value,
                              ),
                            );
                            _saveSettings();
                          },
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            final defaults = const GameSettings();
                            setState(() => _settings = defaults);
                            await _saveSettings();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                          ),
                          child: const Text('Reset Progress'),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0x22161A3C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF6C4BFF).withAlpha(120)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFF00D2FF),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
