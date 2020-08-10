import 'package:dio/dio.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';

class AuthService {
  static const String kAuthBaseUrl = '${AppConfig.kApiBaseUrl}/auth';

  Future<User> login(String email, String password) async {
    try {
      final Response res = await Dio().post(
        '$kAuthBaseUrl/login',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "email": email,
          "password": password,
        },
      );

      if (res.statusCode != 201) throw Failure(error: 'Could not login!');
      return User.fromMap(res.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw Failure(error: e.message);
    } catch (e) {
      throw Failure(error: 'Could not login!');
    }
  }

  Future<User> signUp(String username, String email, String password) async {
    try {
      final Response res = await Dio().post(
        '$kAuthBaseUrl/signup',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "email": email,
          "name": username,
          "password": password,
        },
      );

      if (res.statusCode != 201) throw Failure(error: 'Could not sign up!');
      return User.fromMap(res.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw Failure(error: e.message);
    } catch (e) {
      throw Failure(error: 'Could not sign up!');
    }
  }

  Future<bool> logout(User user) async {
    try {
      final Response res = await Dio().get(
        '$kAuthBaseUrl/logout/${user.id}',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
      );

      if (res.statusCode != 200) throw Failure(error: 'Could not logout!');
      return true;
    } on DioError catch (e) {
      throw Failure(error: e.message);
    } catch (e) {
      throw Failure(error: 'Could not sign up!');
    }
  }
}
