import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF36C7CB);
  static const Color secondary = Color(0xFFD93636);
  static const Color dark = Color(0xFF181818);
  static const Color light = Color(0xFFDFDFE5);
  static const Color disabled = Color(0xFF9496C1);
  static const Color background = Color(0xFFFFFFFF);

  static final Color barrier = dark.withOpacity(0.6);

  static const List<Color> accentColors = [
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
}
