import 'dart:math' as math;

class AppFormatters {
  AppFormatters._();

  static String formatScore(int score) => score.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => ',',
  );

  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static String formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    }
    if (difference.inDays >= 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    }
    if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    }
    if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    }
    if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m ago';
    }
    return 'Just now';
  }

  static String formatNumber(double value, {int decimals = 1}) {
    return value.toStringAsFixed(decimals);
  }

  static double clamp(double value, double min, double max) {
    return math.min(math.max(value, min), max);
  }
}
