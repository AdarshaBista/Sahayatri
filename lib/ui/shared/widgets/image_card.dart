import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/custom_card.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final EdgeInsets margin;

  const ImageCard({
    this.margin = const EdgeInsets.all(6.0),
    @required this.imageUrl,
  }) : assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: margin,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
