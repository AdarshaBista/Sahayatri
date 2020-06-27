import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/core/database/weather_dao.dart';

class WeatherService {
  static const int kCacheDuration = 20;

  final ApiService apiService;
  final WeatherDao weatherDao;

  WeatherService({
    @required this.apiService,
    @required this.weatherDao,
  })  : assert(apiService != null),
        assert(weatherDao != null);

  Future<List<Weather>> fetchForecasts(Coord coord) async {
    final forecasts = await weatherDao.get(coord.toString());
    if (_isValid(forecasts)) return forecasts;

    try {
      final List<Weather> forecasts = await apiService.fetchForecasts(coord);
      weatherDao.upsert(coord.toString(), forecasts);
      return forecasts;
    } on Failure {
      rethrow;
    }
  }

  bool _isValid(List<Weather> forecasts) {
    if (forecasts == null) return false;

    final createdAt = forecasts.first.createdAt;
    final now = DateTime.now();
    return now.difference(createdAt) < const Duration(minutes: kCacheDuration);
  }
}
