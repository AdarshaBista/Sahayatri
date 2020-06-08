import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle _base = TextStyle(
    color: AppColors.dark,
    fontFamily: Values.kFontFamily,
  );

  static final TextStyle huge = _base.copyWith(
    fontSize: 32.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.2,
  );

  static final TextStyle extraLarge = _base.copyWith(
    fontSize: 26.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
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
    fontWeight: FontWeight.w300,
    color: AppColors.dark.withOpacity(0.7),
  );

  static final TextStyle extraSmall = _base.copyWith(
    fontSize: 11.0,
    fontWeight: FontWeight.w200,
    color: AppColors.dark.withOpacity(0.7),
  );
}

extension TextStyleX on TextStyle {
  TextStyle get serif => copyWith(fontFamily: Values.kFontFamilySerif);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get light => copyWith(color: AppColors.background);
  TextStyle get extraLight => copyWith(
        color: AppColors.background.withOpacity(0.7),
      );
}
