import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle _base = TextStyle(
    color: AppColors.dark,
    fontFamily: AppConfig.kFontFamily,
  );

  static final TextStyle huge = _base.copyWith(
    fontSize: 32.0,
    letterSpacing: 1.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle extraLarge = _base.copyWith(
    fontSize: 26.0,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle large = _base.copyWith(
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium = _base.copyWith(
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle small = _base.copyWith(
    fontSize: 14.0,
    color: AppColors.barrier,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle extraSmall = _base.copyWith(
    fontSize: 11.0,
    color: AppColors.barrier,
    fontWeight: FontWeight.w200,
  );
}

extension TextStyleX on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w200);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get secondary => copyWith(color: AppColors.secondary);
  TextStyle get light => copyWith(color: AppColors.light);
  TextStyle get lightAccent => copyWith(color: AppColors.lightAccent);
  TextStyle get dark => copyWith(color: AppColors.dark);
  TextStyle get darkAccent => copyWith(color: AppColors.darkAccent);
  TextStyle get serif => copyWith(fontFamily: AppConfig.kFontFamilySerif);
}
