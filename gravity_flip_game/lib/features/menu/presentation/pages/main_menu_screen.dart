import 'package:flutter/material.dart';

import '../components/menu_button.dart';
import 'settings_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Gravity Flip',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Master the gravity, beat the levels',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MenuButton(
                    label: 'Play',
                    icon: Icons.play_arrow_rounded,
                    isPrimary: true,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Game start flow goes here.'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  MenuButton(
                    label: 'Levels',
                    icon: Icons.layers_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Levels screen goes here.'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  MenuButton(
                    label: 'Leaderboard',
                    icon: Icons.leaderboard_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Leaderboard screen goes here.'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  MenuButton(
                    label: 'Achievements',
                    icon: Icons.emoji_events_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Achievements screen goes here.'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  MenuButton(
                    label: 'Settings',
                    icon: Icons.settings_rounded,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.info_outline_rounded),
                    label: const Text('About'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Exit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
