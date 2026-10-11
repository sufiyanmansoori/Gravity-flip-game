extension IntExtensions on int {
  bool get isEven => this % 2 == 0;

  bool get isOdd => !isEven;

  int get positiveValue => this < 0 ? -this : this;

  int coerceRange(int min, int max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}
