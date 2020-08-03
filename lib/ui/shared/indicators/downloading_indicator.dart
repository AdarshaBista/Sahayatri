import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class DownloadingIndicator extends StatelessWidget {
  final String title;

  const DownloadingIndicator({
    this.title = 'required data',
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Images.kDownloading,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 32.0,
            height: 32.0,
            child: LoadingIndicator(
              color: AppColors.primary,
              indicatorType: Indicator.ballRotateChase,
            ),
          ),
          const SizedBox(height: 32.0),
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
