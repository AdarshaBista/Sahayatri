import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  bool get isDark => state == ThemeMode.dark;

  void changeTheme(bool isDark) {
    if (isDark) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }
}
