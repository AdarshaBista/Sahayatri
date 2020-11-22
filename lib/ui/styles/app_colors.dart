import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF36C7CB);
  static const Color primaryDark = Color(0xFF009688);
  static final Color primaryLight = primary.withOpacity(0.3);

  static const Color secondary = Color(0xFFBA262B);
  static const Color secondaryDark = Color(0xFF810020);
  static final Color secondaryLight = secondary.withOpacity(0.3);

  static const Color dark = Color(0xFF222222);
  static const Color darkAccent = Color(0xFF313131);
  static final Color darkFaded = dark.withOpacity(0.7);

  static const Color light = Color(0xFFFFFFFF);
  static const Color lightAccent = Color(0xFFDFDFE5);
  static final Color lightFaded = light.withOpacity(0.7);

  static const List<Color> accents = [
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

  static final List<Color> cardGradient = [
    AppColors.dark.withOpacity(0.8),
    AppColors.dark.withOpacity(0.5),
    AppColors.dark.withOpacity(0.2),
    Colors.transparent,
  ];

  static final List<Color> collapsibleHeaderGradient = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    AppColors.light.withOpacity(0.2),
    AppColors.light.withOpacity(0.5),
    AppColors.light.withOpacity(0.8),
    AppColors.light,
  ];

  static final drawerGradient = AppColors.accents.take(3).toList();
  static final routeGradient = AppColors.accents.take(4).toList();
  static final userTrackGradient = AppColors.accents.getRange(5, 7).toList();
}
