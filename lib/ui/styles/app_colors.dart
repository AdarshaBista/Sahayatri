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
  static final darkFaded = dark.withOpacity(0.6);

  static const light = Color(0xFFFFFFFF);
  static const lightAccent = Color(0xFFEAEAFA);
  static final lightFaded = light.withOpacity(0.6);

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
    AppColors.dark.withOpacity(0.0),
  ];

  static List<Color> getCollapsibleHeaderGradient(Color color) {
    return [
      color.withOpacity(0.0),
      color.withOpacity(0.0),
      color.withOpacity(0.0),
      color.withOpacity(0.0),
      color.withOpacity(0.2),
      color.withOpacity(0.5),
      color.withOpacity(0.8),
      color,
    ];
  }

  static final routeGradient = accents.getRange(0, 4).toList();
  static final drawerGradient = accents.getRange(6, 8).toList();
  static final userTrackGradient = accents.getRange(5, 8).toList();
}
