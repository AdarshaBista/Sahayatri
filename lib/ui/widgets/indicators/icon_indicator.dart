import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class IconIndicator extends StatelessWidget {
  final Widget title;
  final double padding;
  final String imageUrl;

  const IconIndicator({
    required this.title,
    required this.imageUrl,
    this.padding = 64.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12.0),
        child: ScaleAnimator(
          duration: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imageUrl,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 20.0),
              title,
            ],
          ),
        ),
      ),
    );
  }
}
