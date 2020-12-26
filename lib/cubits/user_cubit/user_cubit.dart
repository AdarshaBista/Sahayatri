import 'dart:io';

import 'package:meta/meta.dart';

import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/app_error.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/auth_service.dart';

import 'package:sahayatri/app/database/user_dao.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserDao userDao = locator();
  final ApiService apiService = locator();
  final AuthService authService = locator();

  final Function() onLogout;
  final Function(User) onAuthenticated;

  UserCubit({
    @required this.onLogout,
    @required this.onAuthenticated,
  })  : assert(onLogout != null),
        assert(onAuthenticated != null),
        super(const AuthLoading());

  User get user {
    try {
      return (state as Authenticated).user;
    } catch (_) {
      return null;
    }
  }

  Future<void> checkUserLogin() async {
    final user = await userDao.get();
    if (user == null) {
      emit(const Unauthenticated());
    } else {
      emit(Authenticated(user: user));
    }
  }

  Future<bool> updateAvatar(ImageSource source) async {
    if (Platform.isWindows) return false;

    final pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage == null) return false;

    final newUrl = await apiService.updateUserAvatar(user, pickedImage.path);
    if (newUrl == null) return false;

    final updatedUser = user.copyWith(imageUrl: newUrl);
    await userDao.upsert(updatedUser);
    emit(Authenticated(user: updatedUser));
    return true;
  }

  Future<bool> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await authService.login(email, password);
      await userDao.upsert(user);
      emit(Authenticated(user: user));
      return true;
    } on AppError {
      emit(const Unauthenticated());
      return false;
    }
  }

  Future<bool> signUp(String username, String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await authService.signUp(username, email, password);
      await userDao.upsert(user);
      emit(Authenticated(user: user));
      return true;
    } on AppError {
      emit(const Unauthenticated());
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await authService.logout(user);
      await userDao.delete();
      onLogout();
      emit(const Unauthenticated());
      return true;
    } on AppError {
      emit(Authenticated(user: user));
      return false;
    }
  }

  @override
  void onChange(Change<UserState> change) {
    super.onChange(change);

    final nextState = change.nextState;
    if (nextState is Authenticated) {
      onAuthenticated(nextState.user);
    }
  }
}
