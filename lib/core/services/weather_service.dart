import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/app_error.dart';

import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/app/database/weather_dao.dart';

class WeatherService {
  static const int cacheDuration = 20;

  final ApiService apiService;
  final WeatherDao weatherDao;

  WeatherService({
    @required this.apiService,
    @required this.weatherDao,
  })  : assert(apiService != null),
        assert(weatherDao != null);

  /// Fetches weather for a given [coord] from local cache.
  /// If cache has expired, fetches weather from OpenWeatherMap one call API
  Future<List<Weather>> fetchForecasts(Coord coord) async {
    final forecasts = await weatherDao.get(coord.toString());
    if (_isCacheValid(forecasts)) return forecasts;

    try {
      final List<Weather> forecasts = await apiService.fetchForecasts(coord);
      weatherDao.upsert(coord.toString(), forecasts);
      return forecasts;
    } on AppError {
      rethrow;
    }
  }

  /// Checks the validity of the weather cache for a given coord.
  /// Cache is only maintained for [KCacheDuration] minutes.
  bool _isCacheValid(List<Weather> forecasts) {
    if (forecasts == null) return false;

    final createdAt = forecasts.first.createdAt;
    final now = DateTime.now();
    return now.difference(createdAt) < const Duration(minutes: cacheDuration);
  }
}
