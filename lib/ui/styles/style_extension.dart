import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/configs.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get primaryDark => copyWith(color: AppColors.primaryDark);
  TextStyle get primaryLight => withColor(AppColors.primary.withOpacity(0.25));

  TextStyle get secondary => copyWith(color: AppColors.secondary);
  TextStyle get secondaryDark => copyWith(color: AppColors.secondaryDark);
  TextStyle get secondaryLight =>
      withColor(AppColors.secondary.withOpacity(0.25));

  TextStyle get light => copyWith(color: AppColors.light);
  TextStyle get lightFaded => copyWith(color: AppColors.lightFaded);
  TextStyle get lightAccent => copyWith(color: AppColors.lightAccent);

  TextStyle get dark => copyWith(color: AppColors.dark);
  TextStyle get darkFaded => copyWith(color: AppColors.darkFaded);
  TextStyle get darkAccent => copyWith(color: AppColors.darkFaded);

  TextStyle get serif => copyWith(fontFamily: AppConfig.fontFamilySerif);

  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

extension ContextStyleExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get t => Theme.of(this).textTheme;
  ColorScheme get c => Theme.of(this).colorScheme;
}
