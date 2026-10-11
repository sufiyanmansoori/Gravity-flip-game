import 'package:flutter/material.dart';

import '../components/menu_button.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Options')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              MenuButton(
                label: 'Sound & Music',
                icon: Icons.music_note_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Music settings opened.')),
                  );
                },
              ),
              const SizedBox(height: 12),
              MenuButton(
                label: 'Graphics',
                icon: Icons.display_settings_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Graphics settings opened.')),
                  );
                },
              ),
              const SizedBox(height: 12),
              MenuButton(
                label: 'Controls',
                icon: Icons.gamepad_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Controls settings opened.')),
                  );
                },
              ),
              const SizedBox(height: 12),
              MenuButton(
                label: 'Privacy',
                icon: Icons.privacy_tip_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Privacy preferences opened.'),
                    ),
                  );
                },
              ),
              const Spacer(),
              MenuButton(
                label: 'Back',
                icon: Icons.arrow_back_rounded,
                isPrimary: true,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
