import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final EdgeInsets margin;
  final double borderRadius;

  const ImageCard({
    this.margin = const EdgeInsets.all(4.0),
    @required this.imageUrl,
    this.borderRadius = 8.0,
  })  : assert(imageUrl != null),
        assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      margin: margin,
      borderRadius: borderRadius,
      child: AdaptiveImage(imageUrl),
    );
  }
}
