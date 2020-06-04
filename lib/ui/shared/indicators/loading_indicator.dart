import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Values.kLoadingImage,
      title: Center(
        child: BallRotateIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
