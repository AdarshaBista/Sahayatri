import 'dart:math' as math;

import 'package:meta/meta.dart';

import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/constants/configs.dart';

class GeoUtils {
  /// Determine if [coord] is in [path] within a given [tolerance].
  static bool isOnPath(Coord coord, List<Coord> path,
      [double tolerance = LocationConfig.minNearbyDistance]) {
    return PolygonUtil.isLocationOnPath(
      LatLng(coord.lat, coord.lng),
      path.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: LocationConfig.minNearbyDistance,
    );
  }

  /// Calculate distance between [start] and [end] in metres.
  static double computeDistance(Coord start, Coord end) {
    return SphericalUtil.computeDistanceBetween(
      LatLng(start.lat, start.lng),
      LatLng(end.lat, end.lng),
    ).toDouble();
  }

  /// Calculate length of [path] in metres.
  static double computeLength(List<Coord> path) {
    final points = path.map((p) => LatLng(p.lat, p.lng)).toList();
    return SphericalUtil.computeLength(points).toDouble();
  }

  /// Index of a [Coord] closest to a [point] on the path.
  /// This index determines the position of [point] along a path.
  static int indexOnPath(Coord point, List<Coord> path) {
    int nearestIndex;
    double shortestDistanceSq = double.infinity;

    for (int i = 0; i < path.length; ++i) {
      final distanceSq = math.pow(path[i].lng - point.lng, 2).toDouble() +
          math.pow(path[i].lat - point.lat, 2).toDouble();

      if (distanceSq < shortestDistanceSq) {
        nearestIndex = i;
        shortestDistanceSq = distanceSq;
      }
    }
    return nearestIndex;
  }

  /// Distance between [start] and [end] indices of a [path].
  static double distanceBetweenIndices(List<Coord> path,
      {int start = 0, @required int end}) {
    final points = path.getRange(start, end).toList();
    return computeLength(points);
  }
}
