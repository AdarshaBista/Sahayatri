import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/api_service.dart';

class WeatherService {
  final ApiService apiService;
  final Map<Coord, List<Weather>> forecastsCache = {};

  WeatherService({
    @required this.apiService,
  }) : assert(apiService != null);

  Future<List<Weather>> fetchWeather(Coord coord) async {
    if (forecastsCache.containsKey(coord)) return forecastsCache[coord];

    try {
      final List<Weather> forecasts = await apiService.fetchWeather(coord);
      forecastsCache[coord] = forecasts;
      return forecasts;
    } on Failure {
      rethrow;
    }
  }
}
