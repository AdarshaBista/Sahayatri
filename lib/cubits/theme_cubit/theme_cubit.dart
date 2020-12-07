import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/app/constants/configs.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  bool get isDark => state == ThemeMode.dark;
  String get themeStr => state.toString().split('.').last;

  void changeTheme(ThemeMode mode) {
    if (state != mode) emit(mode);
  }

  void init(String theme) {
    if (theme == ThemeStyles.dark) {
      emit(ThemeMode.dark);
    } else if (theme == ThemeStyles.light) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }
}
