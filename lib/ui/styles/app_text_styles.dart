import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle _base = TextStyle(
    color: AppColors.dark,
    fontFamily: AppConfig.fontFamily,
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
    fontSize: 21.0,
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
    fontSize: 10.0,
    color: AppColors.barrier,
    fontWeight: FontWeight.w200,
  );
}
