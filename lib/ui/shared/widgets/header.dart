import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

enum SlideDirection { left, right }

class Header extends StatelessWidget {
  final String title;
  final String boldTitle;
  final double leftPadding;
  final SlideDirection slideDirection;

  const Header({
    this.title,
    this.boldTitle,
    this.leftPadding = 20.0,
    this.slideDirection = SlideDirection.left,
  })  : assert(leftPadding != null),
        assert(slideDirection != null);

  @override
  Widget build(BuildContext context) {
    final double boldTitleTopPadding = title == null ? 16.0 : 0.0;
    final dir = slideDirection == SlideDirection.left ? -1.0 : 1.0;

    return SlideAnimator(
      begin: Offset(dir * 0.8, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: EdgeInsets.only(left: leftPadding, top: 20.0),
              child: Text(
                title,
                style: AppTextStyles.extraLarge.thin,
              ),
            ),
          if (boldTitle != null)
            Padding(
              padding: EdgeInsets.only(left: leftPadding, top: boldTitleTopPadding),
              child: Text(
                boldTitle,
                style: AppTextStyles.huge.thin,
              ),
            ),
        ],
      ),
    );
  }
}
