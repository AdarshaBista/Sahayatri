import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => const TextStyle(
        color: AppColors.dark,
        fontFamily: AppConfig.fontFamily,
      );

  static TextStyle get headline1 => _base.copyWith(
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headline2 => _base.copyWith(
        fontSize: 26.0,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get headline3 => _base.copyWith(
        fontSize: 21.0,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get headline4 => _base.copyWith(
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get headline5 => _base.copyWith(
        fontSize: 14.0,
        color: AppColors.darkFaded,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get headline6 => _base.copyWith(
        fontSize: 10.0,
        color: AppColors.darkFaded,
        fontWeight: FontWeight.w200,
      );
}
