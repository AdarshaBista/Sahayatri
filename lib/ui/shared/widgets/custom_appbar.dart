import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class CustomAppbar extends AppBar {
  CustomAppbar({
    @required String title,
    Widget leading,
    double elevation = 8.0,
    Color color = AppColors.light,
  }) : super(
          centerTitle: true,
          leading: leading,
          backgroundColor: color,
          elevation: elevation,
          iconTheme: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
              ? AppThemes.lightIconTheme
              : AppThemes.darkIconTheme,
          title: SlideAnimator(
            begin: const Offset(0.0, -0.2),
            child: FadeAnimator(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                    ? AppTextStyles.medium.light
                    : AppTextStyles.medium.bold,
              ),
            ),
          ),
        );
}
