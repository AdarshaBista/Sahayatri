class MathUtils {
  // Map input range [ix, iy] to output range [ox, oy]
  static double mapRange(
    double value,
    double iMin,
    double iMax,
    double oMin,
    double oMax,
  ) {
    final double slope = (oMax + 1.0 - oMin) / (iMax - iMin);
    return oMin + slope * (value - iMin);
  }

  // Map input range [ix, iy] to output range [oy, ox]
  static double mapRangeInverse(
    double value,
    double iMin,
    double iMax,
    double oMin,
    double oMax,
  ) {
    final double output = mapRange(value, iMin, iMax, oMin, oMax);
    return oMin + oMax - output;
  }
}
