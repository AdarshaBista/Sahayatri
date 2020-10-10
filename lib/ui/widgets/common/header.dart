import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

enum SlideDirection { left, right }

class Header extends StatelessWidget {
  final bool isSerif;
  final String title;
  final String boldTitle;
  final double padding;
  final SlideDirection slideDirection;

  const Header({
    this.title,
    this.boldTitle,
    this.isSerif = false,
    this.padding = 20.0,
    this.slideDirection = SlideDirection.left,
  })  : assert(isSerif != null),
        assert(padding != null),
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
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Text(
                title,
                style: isSerif
                    ? AppTextStyles.extraLarge.thin.serif
                    : AppTextStyles.extraLarge.thin,
              ),
            ),
          if (boldTitle != null)
            Padding(
              padding: EdgeInsets.only(
                left: padding,
                right: padding,
                top: boldTitleTopPadding,
              ),
              child: Text(
                boldTitle,
                style: isSerif ? AppTextStyles.huge.thin.serif : AppTextStyles.huge.thin,
              ),
            ),
        ],
      ),
    );
  }
}
