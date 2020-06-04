import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class CustomAppbar extends AppBar {
  CustomAppbar({
    @required String title,
    double elevation: 8.0,
  }) : super(
          centerTitle: true,
          elevation: elevation,
          title: SlideAnimator(
            begin: const Offset(0.0, -100.0),
            child: FadeAnimator(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.medium.bold,
              ),
            ),
          ),
        );
}
