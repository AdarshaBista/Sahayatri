import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/style_x.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF36C7CB);
  static const primaryDark = Color(0xFF009688);
  static const primaryLight = Color(0xFFAEE8EA);

  static const secondary = Color(0xFFD93636);
  static const secondaryDark = Color(0xFF8F0000);
  static const secondaryLight = Color(0xFFFFADAD);

  static const dark = Color(0xFF222222);
  static const darkAccent = Color(0xFF3C3C3C);
  static final darkFaded = dark.withOpacity(0.7);

  static const light = Color(0xFFFFFFFF);
  static const lightAccent = Color(0xFFDFDFE5);
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

  static List<Color> getCollapsibleHeaderGradient(BuildContext context) {
    final bgColor = context.c.background;
    return [
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      bgColor.withOpacity(0.2),
      bgColor.withOpacity(0.5),
      bgColor.withOpacity(0.8),
      bgColor,
    ];
  }

  static final drawerGradient = AppColors.accents.take(3).toList();
  static final routeGradient = AppColors.accents.take(4).toList();
  static final userTrackGradient = AppColors.accents.getRange(5, 7).toList();
}
