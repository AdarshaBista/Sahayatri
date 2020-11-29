import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

enum SlideDirection { left, right }

class Header extends StatelessWidget {
  final String title;
  final double padding;
  final double fontSize;
  final SlideDirection slideDirection;

  const Header({
    @required this.title,
    this.padding = 20.0,
    this.fontSize = 25.0,
    this.slideDirection = SlideDirection.left,
  })  : assert(title != null),
        assert(padding != null),
        assert(fontSize != null),
        assert(slideDirection != null);

  @override
  Widget build(BuildContext context) {
    final dir = slideDirection == SlideDirection.left ? -1.0 : 1.0;

    return SlideAnimator(
      begin: Offset(dir * 0.8, 0.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Text(
          title,
          style: context.t.headline2.thin.withSize(fontSize),
        ),
      ),
    );
  }
}
