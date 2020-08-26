import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/core/utils/image_utils.dart';

class AdaptiveImage extends StatelessWidget {
  final String imageUrl;
  final Color color;

  const AdaptiveImage(
    this.imageUrl, {
    this.color = Colors.transparent,
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    final imageType = ImageUtils.getImageType(imageUrl);

    switch (imageType) {
      case ImageType.asset:
        return Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          color: color,
          colorBlendMode: BlendMode.srcATop,
          errorBuilder: _buildError,
        );
      case ImageType.network:
        return Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          color: color,
          colorBlendMode: BlendMode.srcATop,
          errorBuilder: _buildError,
          loadingBuilder: _buildLoading,
        );
      case ImageType.file:
        return Image.file(
          File(imageUrl),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          color: color,
          colorBlendMode: BlendMode.srcATop,
          errorBuilder: _buildError,
        );
      default:
        return const Offstage();
    }
  }

  Widget _buildLoading(BuildContext context, Widget child, ImageChunkEvent progress) {
    if (progress == null) return child;
    return const Center(
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
