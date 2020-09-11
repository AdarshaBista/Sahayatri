import 'package:dio/dio.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/reviews_list.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/api_keys.dart';

class ApiService {
  Future<String> updateUserAvatar(User user, String imagePath) async {
    try {
      final Response res = await Dio().post(
        '${ApiConfig.kApiBaseUrl}/users/${user.id}/images',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
        data: FormData()
          ..files.add(MapEntry(
            'images',
            await MultipartFile.fromFile(imagePath, filename: '${user.id}_avatar.png'),
          )),
      );
      final body = res.data as Map<String, dynamic>;
      return body['imageUrl'] as String;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Destination>> fetchDestinations() async {
    try {
      final Response res = await Dio().get('${ApiConfig.kApiBaseUrl}/destinations');
      final body = res.data as Map<String, dynamic>;
      final destinations = body['data'] as List<dynamic>;
      return destinations
          .map((d) {
            try {
              return Destination.fromMap(d as Map<String, dynamic>);
            } catch (e) {
              print(e.toString());
              return null;
            }
          })
          .where((d) => d != null)
          .toList();
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to get destinations.');
    }
  }

  Future<ReviewsList> fetchReviews(String destId, int page) async {
    try {
      final Response res = await Dio().get(
        '${ApiConfig.kApiBaseUrl}/destinations/$destId/reviews',
        queryParameters: {
          'limit': ApiConfig.kReviewsLimit,
          'page': page,
        },
      );
      final body = res.data as Map<String, dynamic>;
      return ReviewsList.fromMap(body);
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to get reviews.');
    }
  }

  Future<String> postDestinationReview(
      double rating, String text, String destId, User user) async {
    try {
      final Response res = await Dio().post(
        '${ApiConfig.kApiBaseUrl}/reviews',
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
      return body['review']['id'] as String;
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to post review.');
    }
  }

  Future<List<Place>> fetchPlaces(String destId, User user) async {
    try {
      final Response res = await Dio().get(
        '${ApiConfig.kApiBaseUrl}/destinations/$destId/places',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
      );
      final places = res.data as List<dynamic>;
      return places
          .map((p) {
            try {
              return Place.fromMap(p as Map<String, dynamic>);
            } catch (e) {
              print(e.toString());
              return null;
            }
          })
          .where((p) => p != null)
          .toList();
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to get places.');
    }
  }

  Future<List<Itinerary>> fetchItineraries(String destId, User user) async {
    try {
      final Response res = await Dio().get(
        '${ApiConfig.kApiBaseUrl}/destinations/$destId/itineraries',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
      );
      final itineraries = res.data as List<dynamic>;
      return itineraries
          .map((i) {
            try {
              return Itinerary.fromMap(i as Map<String, dynamic>);
            } catch (e) {
              print(e.toString());
              return null;
            }
          })
          .where((i) => i != null)
          .toList();
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to get suggested itineraries.');
    }
  }

  Future<ReviewsList> fetchLodgeReviews(String lodgeId, int page, User user) async {
    try {
      final Response res = await Dio().get(
        '${ApiConfig.kApiBaseUrl}/lodges/$lodgeId/reviews',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
        queryParameters: {
          'limit': ApiConfig.kReviewsLimit,
          'page': page,
        },
      );

      final body = res.data as Map<String, dynamic>;
      return ReviewsList.fromMap(body);
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to get lodge reviews.');
    }
  }

  Future<String> postLodgeReview(
      double rating, String text, String lodgeId, User user) async {
    try {
      final Response res = await Dio().post(
        '${ApiConfig.kApiBaseUrl}/lodgereviews',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
        data: {
          "text": text,
          "rating": rating,
          "user": {"id": user.id},
          "lodge": {"id": lodgeId}
        },
      );
      final body = res.data as Map<String, dynamic>;
      return body['review']['id'] as String;
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to post lodge review.');
    }
  }

  Future<Destination> download(String destId, User user) async {
    try {
      final Response res = await Dio().get(
        '${ApiConfig.kApiBaseUrl}/destinations/$destId/download',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
      );
      return Destination.fromMap(res.data as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Failed to download data.');
    }
  }

  Future<List<Weather>> fetchForecasts(Coord coord) async {
    try {
      final Response res = await Dio().get(
        '${ApiConfig.kWeatherApiBaseUrl}/onecall?lat=${coord.lat}&lon=${coord.lng}&units=metric&exclude=hourly,current&appid=${ApiKeys.kOpenWeatherMapKey}',
      );
      final resList = res.data['daily'] as List<dynamic>;
      return resList.map((m) => Weather.fromMap(m as Map<String, dynamic>)).toList();
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Unable to get weather.');
    }
  }
}
