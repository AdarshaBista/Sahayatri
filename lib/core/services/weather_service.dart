import 'package:dio/dio.dart';

import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';

class WeatherService {
  static const String kBaseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<List<Weather>> fetchWeather(Coord coord) async {
    try {
      final Response res = await Dio().get(
          '$kBaseUrl/onecall?lat=${coord.lat}&lon=${coord.lng}&exclude=hourly,current&appid=${ApiKeys.kOpenWeatherMapKey}');
      final List<dynamic> resList = res.data['daily'] as List<dynamic>;
      return resList.map((m) => Weather.fromMap(m as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Failure(
        error: e.toString(),
        message: 'Unable to get weather.',
      );
    }
  }
}
