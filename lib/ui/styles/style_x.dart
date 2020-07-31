import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';

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
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}