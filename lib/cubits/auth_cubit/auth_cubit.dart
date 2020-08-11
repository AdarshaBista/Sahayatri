import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/auth_service.dart';

import 'package:sahayatri/app/database/user_dao.dart';
import 'package:sahayatri/core/services/nearby_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserDao userDao;
  final AuthService authService;
  final NearbyService nearbyService;
  final TrackerService trackerService;

  AuthCubit({
    @required this.userDao,
    @required this.authService,
    @required this.nearbyService,
    @required this.trackerService,
  })  : assert(userDao != null),
        assert(authService != null),
        assert(nearbyService != null),
        assert(trackerService != null),
        super(const Unauthenticated());

  bool get isAuthenticated => state is Authenticated;

  Future<bool> getUser() async {
    final user = await userDao.get();
    if (user == null) return false;
    emit(Authenticated(user: user));
    return true;
  }

  Future<bool> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await authService.login(email, password);
      await userDao.save(user);
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
      await userDao.save(user);
      emit(Authenticated(user: user));
      return true;
    } on Failure catch (e) {
      emit(AuthError(message: e.message));
      emit(const Unauthenticated());
      return false;
    }
  }

  Future<void> logout() async {
    final user = (state as Authenticated).user;
    emit(const AuthLoading());
    try {
      await authService.logout(user);
      await userDao.remove(user);
      await nearbyService.stop();
      trackerService.stop();
      emit(const Unauthenticated());
    } on Failure catch (e) {
      emit(AuthError(message: e.message));
      emit(Authenticated(user: user));
    }
  }
}
