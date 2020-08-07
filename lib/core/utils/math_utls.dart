class MathUtils {
  // Map input range [ix, iy] to output range [ox, oy]
  static double mapRange(
    double value,
    double minInput,
    double maxInput,
    double minOutput,
    double maxOutput,
  ) {
    final double slope = (maxOutput + 1.0 - minOutput) / (maxInput - minInput);
    return minOutput + slope * (value - minInput);
  }

  // Map input range [ix, iy] to output range [oy, ox]
  static double mapRangeInverse(
    double value,
    double minInput,
    double maxInput,
    double minOutput,
    double maxOutput,
  ) {
    final double output = mapRange(value, minInput, maxInput, minOutput, maxOutput);
    return minOutput + maxOutput - output;
  }
}
