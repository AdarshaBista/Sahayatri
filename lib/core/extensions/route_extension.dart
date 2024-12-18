import 'dart:math' as math;

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/utils/math_utls.dart';

extension RouteExtension on List<Coord> {
  double get minLat => map((c) => c.lat).reduce(math.min);
  double get maxLat => map((c) => c.lat).reduce(math.max);
  double get minLng => map((c) => c.lng).reduce(math.min);
  double get maxLng => map((c) => c.lng).reduce(math.max);

  List<Coord> simplify(double zoom) {
    if (zoom > MapConfig.routeAccuracyZoomThreshold) return this;

    final double scaledZoom = MathUtils.mapRange(
      zoom,
      MapConfig.minZoom,
      MapConfig.maxZoom,
      MapConfig.routeAccuracyZoomThreshold,
      MapConfig.maxZoom,
    );

    final int ptsToSkip = MathUtils.mapRangeInverse(
      scaledZoom,
      MapConfig.routeAccuracyZoomThreshold,
      MapConfig.maxZoom,
      MapConfig.maxRouteAccuracy.toDouble(),
      MapConfig.minRouteAccuracy.toDouble(),
    ).toInt();

    if (ptsToSkip < 2) return this;

    final List<Coord> simplifiedRoute = [];
    for (int i = 0; i < length; ++i) {
      if ((i + 1) % ptsToSkip == 0) simplifiedRoute.add(this[i]);
    }

    if (simplifiedRoute.length < 2) return [first, last];
    return simplifiedRoute;
  }
}
