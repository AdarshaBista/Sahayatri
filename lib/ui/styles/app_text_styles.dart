import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/configs.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';
import 'package:sahayatri/ui/styles/style_extension.dart';

class AppTextStyles {
  AppTextStyles._();

  static const _base = TextStyle(
    color: AppColors.dark,
    fontFamily: AppConfig.fontFamily,
  );

  static final headline1 = _base.copyWith(fontSize: 32.0).bold;
  static final headline2 = _base.copyWith(fontSize: 25.0).semiBold;
  static final headline3 = _base.copyWith(fontSize: 20.0).medium;
  static final headline4 = _base.copyWith(fontSize: 17.0).regular;
  static final headline5 = _base.copyWith(fontSize: 14.0, color: AppColors.darkAccent).thin;
  static final headline6 = _base.copyWith(fontSize: 11.0, color: AppColors.darkFaded).thin;
}
