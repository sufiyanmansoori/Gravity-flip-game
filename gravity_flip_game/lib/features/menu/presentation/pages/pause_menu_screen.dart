import 'package:flutter/material.dart';

import '../components/menu_button.dart';
import 'settings_screen.dart';

class PauseMenuScreen extends StatelessWidget {
  const PauseMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF111827),
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Game Paused',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            MenuButton(
              label: 'Resume',
              icon: Icons.play_arrow_rounded,
              isPrimary: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 12),
            MenuButton(
              label: 'Restart',
              icon: Icons.refresh_rounded,
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Restarting level...')),
                );
              },
            ),
            const SizedBox(height: 12),
            MenuButton(
              label: 'Settings',
              icon: Icons.settings_rounded,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            MenuButton(
              label: 'Quit',
              icon: Icons.exit_to_app_rounded,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              isDanger: true,
            ),
          ],
        ),
      ),
    );
  }
}
