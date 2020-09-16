import 'package:sahayatri/core/models/coord.dart';

class ApiUtils {
  static List<Coord> parseRoute(String routeStr) {
    if (routeStr == null || routeStr.isEmpty) return [];

    final List<String> values = routeStr.split(',');
    final List<double> points = values.map((p) => double.tryParse(p) ?? 0.0).toList();

    final List<Coord> route = [];
    for (int i = 0; i < points.length; i += 3) {
      route.add(Coord(
        lat: points[i],
        lng: points[i + 1],
        alt: points[i + 2],
      ));
    }
    return route;
  }

  static String routeToCsv(List<Coord> coords) {
    if (coords == null || coords.isEmpty) return '';

    final StringBuffer routeStrBuffer = StringBuffer();
    for (int i = 0; i < coords.length; ++i) {
      routeStrBuffer.write(coords[i].toCsv());
      if (i < coords.length - 1) routeStrBuffer.write(',');
    }
    return routeStrBuffer.toString();
  }

  static List<String> parseCsv(String csvStr) {
    if (csvStr == null || csvStr.isEmpty) return [];
    return csvStr.split(',');
  }

  static String toCsv(List<String> values) {
    if (values == null || values.isEmpty) return '';
    return values.join(',');
  }
}
