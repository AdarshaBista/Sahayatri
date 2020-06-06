import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final EdgeInsets margin;

  const ImageCard({
    this.margin = const EdgeInsets.all(6.0),
    @required this.imageUrl,
  }) : assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: CustomCard(
        margin: margin,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
