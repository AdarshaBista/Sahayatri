import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';

class CheckpointImages extends StatelessWidget {
  static const kHeight = 22.0;

  final List<String> imageUrls;

  const CheckpointImages({
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kHeight,
      child: Stack(
        children: imageUrls.reversed
            .map(
              (url) => Positioned(
                left: imageUrls.indexOf(url) * 16.0,
                child: Container(
                  width: kHeight,
                  height: kHeight,
                  clipBehavior: Clip.antiAlias,
                  child: AdaptiveImage(url),
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
