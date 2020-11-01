import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';

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
      radius: borderRadius,
      child: AdaptiveImage(imageUrl),
    );
  }
}