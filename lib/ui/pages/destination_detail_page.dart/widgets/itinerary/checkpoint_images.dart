import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/common/image_card.dart';

class CheckpointImages extends StatelessWidget {
  static const double height = 22.0;

  final List<String> imageUrls;

  const CheckpointImages({
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: imageUrls.reversed
            .map(
              (url) => Positioned(
                left: imageUrls.indexOf(url) * 16.0,
                child: Container(
                  width: height,
                  height: height,
                  clipBehavior: Clip.antiAlias,
                  child: ImageCard(
                    imageUrl: url,
                    showLoading: false,
                    margin: const EdgeInsets.all(1.0),
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightAccent,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
