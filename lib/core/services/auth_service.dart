import 'package:dio/dio.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    try {
      final Response res = await Dio().post(
        '${AppConfig.kApiBaseUrl}/auth/login',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "email": email,
          "password": password,
        },
      );

      if (res.statusCode != 201) throw Failure(error: 'Could not login!');
      final resBody = res.data as Map<String, dynamic>;
      return User(
        id: resBody['userid'] as String,
        accessToken: resBody['access_token'] as String,
      );
    } on DioError catch (e) {
      throw Failure(error: e.message);
    } catch (e) {
      throw Failure(error: 'Could not login!');
    }
  }

  Future<User> signUp(String username, String email, String password) async {
    try {
      final Response res = await Dio().post(
        '${AppConfig.kApiBaseUrl}/users',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "email": email,
          "username": username,
          "password": password,
        },
      );

      if (res.statusCode != 201) throw Failure(error: 'Could not sign up!');
      final resBody = res.data as Map<String, dynamic>;
      return User(id: resBody['id'] as String);
    } on DioError catch (e) {
      throw Failure(error: e.message);
    } catch (e) {
      throw Failure(error: 'Could not sign up!');
    }
  }
}
