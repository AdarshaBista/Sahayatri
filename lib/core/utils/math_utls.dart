import 'package:sahayatri/app/constants/configs.dart';

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

  // Wheather list should be simplified based on zoom
  static bool shouldSimplify(double currentZoom, double newZoom) {
    final double zoomDiff = newZoom - currentZoom;
    return newZoom < MapConfig.kRouteAccuracyZoomThreshold &&
        (zoomDiff >= MapConfig.kZoomDiffThreshold ||
            zoomDiff <= -MapConfig.kZoomDiffThreshold);
  }
}
