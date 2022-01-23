import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final bool showLoading;
  final EdgeInsets margin;
  final double borderRadius;
  final Color? backgroundColor;

  const ImageCard({
    required this.imageUrl,
    this.borderRadius = 8.0,
    this.showLoading = true,
    this.margin = const EdgeInsets.all(4.0),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      margin: margin,
      radius: borderRadius,
      color: backgroundColor,
      child: AdaptiveImage(
        imageUrl,
        showLoading: showLoading,
      ),
    );
  }
}
