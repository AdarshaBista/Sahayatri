import 'dart:math' as math;

import 'package:meta/meta.dart';

import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/core/models/coord.dart';

class GeoUtils {
  /// Determine if [coord] is in [path] within a given [tolerance].
  static bool isOnPath(Coord coord, List<Coord> path,
      [double tolerance = Distances.kMinNearbyDistance]) {
    return PolygonUtil.isLocationOnPath(
      LatLng(coord.lat, coord.lng),
      path.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: Distances.kMinNearbyDistance,
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
    Coord nearestCoord;
    double shortestDistanceSq = double.infinity;

    for (final coord in path) {
      final distanceSq = math.pow(coord.lng - point.lng, 2).toDouble() +
          math.pow(coord.lat - point.lat, 2).toDouble();

      if (distanceSq < shortestDistanceSq) {
        nearestCoord = coord;
        shortestDistanceSq = distanceSq;
      }
    }
    return path.indexOf(nearestCoord);
  }

  /// Distance between [start] and [end] indices of a [path].
  static double distanceBetweenIndices(List<Coord> path,
      {int start = 0, @required int end}) {
    final points = path.getRange(start, end).toList();
    return computeLength(points);
  }
}
