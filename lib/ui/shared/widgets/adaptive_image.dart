import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/core/utils/image_utils.dart';

class AdaptiveImage extends StatelessWidget {
  final Color color;
  final String imageUrl;

  const AdaptiveImage(
    this.imageUrl, {
    this.color = Colors.transparent,
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: ImageUtils.getImageProvider(imageUrl),
      color: color,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      colorBlendMode: BlendMode.srcATop,
      errorBuilder: _buildError,
      frameBuilder: _buildFrame,
    );
  }

  Widget _buildFrame(BuildContext context, Widget child, int frame, bool isSync) {
    if (isSync) return child;
    return frame != null
        ? child
        : const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.lightAccent),
            ),
          );
  }

  Widget _buildError(BuildContext context, Object exception, StackTrace stackTrace) {
    return const Center(
      child: Icon(
        Icons.error_outline,
        size: 32.0,
        color: AppColors.lightAccent,
      ),
    );
  }
}
