import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/core/utils/image_utils.dart';

class AdaptiveImage extends StatelessWidget {
  final Color color;
  final bool showLoading;
  final String imageUrl;
  final double? width;
  final double? height;

  const AdaptiveImage(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.showLoading = true,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: ImageUtils.getImageProvider(imageUrl),
      color: color,
      fit: BoxFit.cover,
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      colorBlendMode: BlendMode.srcATop,
      errorBuilder: showLoading ? _buildError : null,
      frameBuilder: showLoading ? _buildFrame : null,
    );
  }

  Widget _buildFrame(
    BuildContext context,
    Widget child,
    int? frame,
    bool isSync,
  ) {
    if (isSync) return child;
    return frame != null
        ? child
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(context.c.surface),
              ),
            ),
          );
  }

  Widget _buildError(
    BuildContext context,
    Object exception,
    StackTrace? stackTrace,
  ) {
    return Center(
      child: Icon(
        AppIcons.error,
        size: 32.0,
        color: context.c.surface,
      ),
    );
  }
}
