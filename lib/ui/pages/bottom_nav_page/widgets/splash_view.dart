import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashView extends StatelessWidget {
  const SplashView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Images.kSplash,
              width: 160.0,
              height: 160.0,
            ),
            const SizedBox(height: 32.0),
            LoadingIndicator(
              color: AppColors.primary,
              indicatorType: Indicator.ballPulse,
            ),
          ],
        ),
      ),
    );
  }
}
