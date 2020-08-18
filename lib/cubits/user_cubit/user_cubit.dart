import 'dart:io';

import 'package:meta/meta.dart';

import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/auth_service.dart';
import 'package:sahayatri/core/services/nearby_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';

import 'package:sahayatri/app/database/user_dao.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserDao userDao;
  final ApiService apiService;
  final AuthService authService;
  final NearbyService nearbyService;
  final TrackerService trackerService;

  UserCubit({
    @required this.userDao,
    @required this.apiService,
    @required this.authService,
    @required this.nearbyService,
    @required this.trackerService,
  })  : assert(userDao != null),
        assert(apiService != null),
        assert(authService != null),
        assert(nearbyService != null),
        assert(trackerService != null),
        super(const Unauthenticated());

  bool get isAuthenticated => state is Authenticated;
  User get user => (state as Authenticated).user;

  Future<bool> getUser() async {
    final user = await userDao.get();
    if (user == null) return false;
    emit(Authenticated(user: user));
    return true;
  }

  Future<bool> updateAvatar(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: source);
    if (pickedImage == null) return false;

    final newUrl = await apiService.updateUserAvatar(user, pickedImage.path);
    if (newUrl != null) {
      final updatedUser = user.copyWith(imageUrl: newUrl);
      await userDao.save(updatedUser);
      emit(Authenticated(user: updatedUser));
    }
    return newUrl != null;
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
      trackerService.stop();
      if (!Platform.isWindows) await nearbyService.stop();
      emit(const Unauthenticated());
    } on Failure catch (e) {
      emit(AuthError(message: e.message));
      emit(Authenticated(user: user));
    }
  }
}
