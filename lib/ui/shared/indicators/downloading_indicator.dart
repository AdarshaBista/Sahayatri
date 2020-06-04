import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class DownloadingIndicator extends StatelessWidget {
  final String title;

  const DownloadingIndicator({
    this.title = 'required data',
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Values.kDownloadingImage,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BallRotateIndicator(
            color: AppColors.primary,
          ),
          const SizedBox(height: 24.0),
          Text(
            'Downloading $title',
            textAlign: TextAlign.center,
            style: AppTextStyles.medium,
          ),
        ],
      ),
    );
  }
}
