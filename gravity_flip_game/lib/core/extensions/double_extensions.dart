extension DoubleExtensions on double {
  double get absValue => this < 0 ? -this : this;

  double coerceRange(double min, double max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  double get roundedToPrecision => double.parse(toStringAsFixed(2));

  bool get isNearZero => absValue < 0.0001;
}
