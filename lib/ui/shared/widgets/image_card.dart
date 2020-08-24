import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final EdgeInsets margin;

  const ImageCard({
    this.margin = const EdgeInsets.all(6.0),
    @required this.imageUrl,
  }) : assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      margin: margin,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
