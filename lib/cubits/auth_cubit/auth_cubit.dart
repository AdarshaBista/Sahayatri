import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit({
    @required this.authService,
  })  : assert(authService != null),
        super(const Unauthenticated());

  bool get isAuthenticated => state is Authenticated;

  Future<bool> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await authService.login(email, password);
      emit(Authenticated(user: user));
      return true;
    } on Failure catch (e) {
      emit(AuthError(message: e.message));
      emit(const Unauthenticated());
      return false;
    }
  }

  Future<bool> signUp(String username, String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await authService.signUp(username, email, password);
      emit(Authenticated(user: user));
      return true;
    } on Failure catch (e) {
      emit(AuthError(message: e.message));
      emit(const Unauthenticated());
      return false;
    }
  }

  Future<bool> logout() async {
    final user = (state as Authenticated).user;
    emit(const AuthLoading());
    try {
      await authService.logout(user);
      emit(const Unauthenticated());
      return true;
    } on Failure catch (e) {
      emit(AuthError(message: e.message));
      emit(Authenticated(user: user));
      return false;
    }
  }
}
