import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';

extension TextStyleX on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w200);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get primaryDark => copyWith(color: AppColors.primaryDark);
  TextStyle get primaryLight => withColor(AppColors.primary.withOpacity(0.25));
  TextStyle get secondary => copyWith(color: AppColors.secondary);
  TextStyle get secondaryDark => copyWith(color: AppColors.secondaryDark);
  TextStyle get secondaryLight => withColor(AppColors.secondary.withOpacity(0.25));
  TextStyle get light => copyWith(color: AppColors.light);
  TextStyle get lightAccent => copyWith(color: AppColors.lightAccent);
  TextStyle get dark => copyWith(color: AppColors.dark);
  TextStyle get darkAccent => copyWith(color: AppColors.darkFaded);
  TextStyle get serif => copyWith(fontFamily: AppConfig.fontFamilySerif);
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

extension ContextStyles on BuildContext {
  TextTheme get t => Theme.of(this).textTheme;
  ColorScheme get c => Theme.of(this).colorScheme;
}
