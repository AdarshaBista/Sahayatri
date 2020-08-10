import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    throw Failure(error: 'Could not login.');
  }

  Future<User> signUp(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    throw Failure(error: 'Could not sign up.');
  }
}
