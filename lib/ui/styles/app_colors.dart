import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF36C7CB);
  static const primaryDark = Color(0xFF009688);
  static final primaryLight = primary.withOpacity(0.3);

  static const secondary = Color(0xFFD93636);
  static const secondaryDark = Color(0xFF8F0000);
  static final secondaryLight = secondary.withOpacity(0.3);

  static const dark = Color(0xFF151515);
  static const darkAccent = Color(0xFF353535);
  static const darkSurface = Color(0xFF252525);
  static final darkFaded = dark.withOpacity(0.7);

  static const light = Color(0xFFFFFFFF);
  static const lightAccent = Color(0xFFE0E0E0);
  static final lightFaded = light.withOpacity(0.7);

  static const accents = [
    Color(0xFF7B1FA2),
    Color(0xFF512DA8),
    Color(0xFF303F9F),
    Color(0xFF1976D2),
    Color(0xFF0288D1),
    Color(0xFF0097A7),
    Color(0xFF00796B),
    Color(0xFF388E3C),
    Color(0xFF689F38),
    Color(0xFFFBC02D),
    Color(0xFFFFA000),
    Color(0xFFF57C00),
  ];

  static final cardGradient = [
    AppColors.dark.withOpacity(0.8),
    AppColors.dark.withOpacity(0.5),
    AppColors.dark.withOpacity(0.2),
    Colors.transparent,
  ];

  static List<Color> getCollapsibleHeaderGradient(Color color) {
    return [
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      color.withOpacity(0.2),
      color.withOpacity(0.5),
      color.withOpacity(0.8),
      color,
    ];
  }

  static final routeGradient = AppColors.accents.take(4).toList();
  static final drawerGradient = AppColors.accents.take(3).toList();
  static final userTrackGradient = AppColors.accents.getRange(5, 7).toList();
}
