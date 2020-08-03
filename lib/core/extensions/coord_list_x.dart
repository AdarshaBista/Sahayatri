import 'dart:math' as math;

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/core/utils/math_utls.dart';

extension CoordListX on List<Coord> {
  double get minLat => map((c) => c.lat).reduce(math.min);
  double get maxLat => map((c) => c.lat).reduce(math.max);
  double get minLong => map((c) => c.lng).reduce(math.min);
  double get maxLong => map((c) => c.lng).reduce(math.max);

  List<Coord> simplify(double zoom) {
    if (zoom > MapConfig.kRouteAccuracyZoomThreshold) return this;

    final double scaledZoom = MathUtils.mapRange(
      zoom,
      MapConfig.kMinZoom,
      MapConfig.kMaxZoom,
      MapConfig.kRouteAccuracyZoomThreshold,
      MapConfig.kMaxZoom,
    );

    final int accuracy = MathUtils.mapRangeInverse(
      scaledZoom,
      MapConfig.kRouteAccuracyZoomThreshold,
      MapConfig.kMaxZoom,
      MapConfig.kMaxRouteAccuracy.toDouble(),
      MapConfig.kMinRouteAccuracy.toDouble(),
    ).toInt();

    return where((c) => (indexOf(c) + 1) % accuracy == 0).toList();
  }
}
