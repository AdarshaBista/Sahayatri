import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class Header extends StatelessWidget {
  final String title;
  final String boldTitle;
  final double leftPadding;

  const Header({
    this.title,
    this.boldTitle,
    this.leftPadding = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final double boldTitleTopPadding = title == null ? 16.0 : 0.0;
    return SlideAnimator(
      begin: const Offset(-200.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: EdgeInsets.only(left: leftPadding, top: 20.0),
              child: Text(
                title,
                style: AppTextStyles.extraLarge,
              ),
            ),
          if (boldTitle != null)
            Padding(
              padding:
                  EdgeInsets.only(left: leftPadding, top: boldTitleTopPadding),
              child: Text(
                boldTitle,
                style: AppTextStyles.huge,
              ),
            ),
        ],
      ),
    );
  }
}
