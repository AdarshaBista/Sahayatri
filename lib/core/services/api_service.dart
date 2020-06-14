import 'package:dio/dio.dart';

import 'package:sahayatri/app/constants/mocks.dart';
import 'package:sahayatri/app/constants/api_keys.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

class ApiService {
  static const String kWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<List<Destination>> fetchDestinations() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return mockDestinations;
    } catch (e) {
      throw Failure(
        error: e.toString(),
        message: 'Failed to get destinations.',
      );
    }
  }

  Future<List<Weather>> fetchForecasts(Coord coord) async {
    try {
      final Response res = await Dio().get(
        '$kWeatherBaseUrl/onecall?lat=${coord.lat}&lon=${coord.lng}&units=metric&exclude=hourly,current&appid=${ApiKeys.kOpenWeatherMapKey}',
      );
      final resList = res.data['daily'] as List<dynamic>;
      return resList.map((m) => Weather.fromMap(m as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Failure(
        error: e.toString(),
        message: 'Unable to get weather.',
      );
    }
  }
}
