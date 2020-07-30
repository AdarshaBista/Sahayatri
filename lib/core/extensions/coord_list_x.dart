import 'dart:math' as math;

import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/coord.dart';

extension CoordListX on List<Coord> {
  double get minLat => map((c) => c.lat).reduce(math.min);
  double get maxLat => map((c) => c.lat).reduce(math.max);
  double get minLong => map((c) => c.lng).reduce(math.min);
  double get maxLong => map((c) => c.lng).reduce(math.max);

  List<Coord> simplify(double zoom) {
    if (zoom > 16.0) return this;

    const double slope = (MapConfig.kMinRouteAccuracy - MapConfig.kMaxRouteAccuracy) /
        (MapConfig.kMaxZoom - MapConfig.kMinZoom);
    final int output =
        (MapConfig.kMaxRouteAccuracy + slope * (zoom - MapConfig.kMinZoom)).toInt();
    final int accuracy =
        (MapConfig.kMinRouteAccuracy + MapConfig.kMaxRouteAccuracy) - output;

    return where((c) => (indexOf(c) + 1) % accuracy == 0).toList();
  }
}
