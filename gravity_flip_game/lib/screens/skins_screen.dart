import 'package:flutter/material.dart';

class SkinOption {
  final String name;
  final Color primary;
  final Color secondary;
  final bool locked;
  final int unlockScore;

  const SkinOption({
    required this.name,
    required this.primary,
    required this.secondary,
    this.locked = false,
    this.unlockScore = 0,
  });
}

class SkinsScreen extends StatefulWidget {
  const SkinsScreen({super.key});

  @override
  State<SkinsScreen> createState() => _SkinsScreenState();
}

class _SkinsScreenState extends State<SkinsScreen> {
  int selectedIndex = 0;

  final skins = <SkinOption>[
    const SkinOption(
      name: 'Neon Blue',
      primary: Color(0xFF00D2FF),
      secondary: Color(0xFF6C4BFF),
    ),
    const SkinOption(
      name: 'Cyber Purple',
      primary: Color(0xFF9C6BFF),
      secondary: Color(0xFF5D5FEF),
      locked: true,
      unlockScore: 250,
    ),
    const SkinOption(
      name: 'Plasma Pink',
      primary: Color(0xFFFF5ECF),
      secondary: Color(0xFFFF7A59),
      locked: true,
      unlockScore: 500,
    ),
    const SkinOption(
      name: 'Toxic Green',
      primary: Color(0xFF78FF7B),
      secondary: Color(0xFF00C49A),
      locked: true,
      unlockScore: 750,
    ),
    const SkinOption(
      name: 'Golden',
      primary: Color(0xFFFFD166),
      secondary: Color(0xFFFF8C42),
      locked: true,
      unlockScore: 1000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF090D18), Color(0xFF141C2B)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                      'SKINS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    itemCount: skins.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                    itemBuilder: (context, index) {
                      final skin = skins[index];
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          if (!skin.locked) {
                            setState(() => selectedIndex = index);
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF00D2FF)
                                  : const Color(0xFF6C4BFF).withAlpha(120),
                              width: isSelected ? 2 : 1,
                            ),
                            gradient: LinearGradient(
                              colors: [skin.primary, skin.secondary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: skin.locked
                                    ? const Icon(
                                        Icons.lock_rounded,
                                        color: Colors.white70,
                                      )
                                    : isSelected
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.white,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              Align(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white24,
                                      ),
                                      child: const Icon(
                                        Icons.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      skin.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (skin.locked)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          '${skin.unlockScore} pts',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
