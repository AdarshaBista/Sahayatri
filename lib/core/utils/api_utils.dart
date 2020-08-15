import 'package:sahayatri/core/models/coord.dart';

class ApiUtils {
  static List<Coord> parseRoute(String routeStr) {
    final List<String> values = routeStr.split(',');
    final List<double> points = values.map((p) => double.tryParse(p) ?? 0.0).toList();

    final int length = points.length ~/ 3;
    final List<Coord> route = [];

    for (int i = 0; i < length; i += 3) {
      route.add(Coord(
        lat: points[i],
        lng: points[i + 1],
        alt: points[i + 2],
      ));
    }
    return route;
  }

  static Coord parseCoord(String coordStr) {
    final List<String> values = coordStr.split(',');
    final List<double> points = values.map((p) => double.tryParse(p) ?? 0.0).toList();

    return Coord(
      lat: points[0],
      lng: points[1],
      alt: points[2],
    );
  }

  static List<String> parseCsv(String csvStr) {
    if (csvStr == null) return [];
    return csvStr.split(',');
  }
}
