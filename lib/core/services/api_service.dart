import 'package:dio/dio.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/api_keys.dart';

class ApiService {
  static const String kWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<List<Destination>> fetchDestinations() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return [];
    } catch (e) {
      throw Failure(
        error: e.toString(),
        message: 'Failed to get destinations.',
      );
    }
  }

  Future<String> postDestinationReview(
    double rating,
    String text,
    String destId,
    User user,
  ) async {
    try {
      final Response res = await Dio().post(
        '${AppConfig.kApiBaseUrl}/reviews',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
        data: {
          "text": text,
          "rating": rating,
          "user": {"id": user.id},
          "destination": {"id": destId}
        },
      );
      final body = res.data as Map<String, dynamic>;
      return body['id'] as String;
    } catch (e) {
      throw Failure(
        error: e.toString(),
        message: 'Failed to post review.',
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
