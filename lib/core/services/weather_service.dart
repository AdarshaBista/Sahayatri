import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/api_service.dart';

class WeatherService {
  final ApiService apiService;
  final Map<Coord, List<Weather>> _forecastsCache = {};

  WeatherService({
    @required this.apiService,
  }) : assert(apiService != null);

  Future<List<Weather>> fetchWeather(Coord coord) async {
    if (_forecastsCache.containsKey(coord)) return _forecastsCache[coord];

    try {
      final List<Weather> forecasts = await apiService.fetchWeather(coord);
      _forecastsCache[coord] = forecasts;
      return _forecastsCache[coord];
    } on Failure {
      rethrow;
    }
  }
}
