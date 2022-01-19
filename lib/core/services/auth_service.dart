import 'package:dio/dio.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/app_error.dart';

import 'package:sahayatri/core/constants/configs.dart';

class AuthService {
  static const String authBaseUrl = '${ApiConfig.apiBaseUrl}/auth';

  Future<User> login(String email, String password) async {
    try {
      final Response res = await Dio().post(
        '$authBaseUrl/login',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "email": email,
          "password": password,
        },
      );
      return User.fromMap(res.data as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Could not login!');
    }
  }

  Future<User> signUp(String username, String email, String password) async {
    try {
      final Response res = await Dio().post(
        '$authBaseUrl/signup',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "email": email,
          "name": username,
          "password": password,
        },
      );
      return User.fromMap(res.data as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Could not sign up!');
    }
  }

  Future<void> logout(User user) async {
    try {
      await Dio().get(
        '$authBaseUrl/logout/${user.id}',
        options: Options(
          headers: {'Authorization': 'Bearer ${user.accessToken}'},
        ),
      );
    } on DioError catch (e) {
      if ((e.response?.statusCode ?? 0) == 401) return;
      print(e.toString());
      throw const AppError(message: 'Could not logout!');
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Could not logout!');
    }
  }
}
