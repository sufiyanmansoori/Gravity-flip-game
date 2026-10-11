import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isPrimary = false,
    this.isDanger = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final accent = isDanger
        ? Colors.redAccent
        : (isPrimary ? Colors.amber : Colors.cyanAccent);

    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        backgroundColor: isPrimary
            ? Colors.amber
            : Colors.white.withValues(alpha: 0.06),
        foregroundColor: isPrimary ? Colors.black87 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(
          color: accent.withValues(alpha: 0.5),
          width: isPrimary ? 1.2 : 0.8,
        ),
      ),
    );
  }
}
