import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class IconIndicator extends StatelessWidget {
  final Widget title;
  final String imageUrl;

  const IconIndicator({
    @required this.title,
    @required this.imageUrl,
  })  : assert(title != null),
        assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imageUrl,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 12.0),
              title,
            ],
          ),
        ),
      ),
    );
  }
}
