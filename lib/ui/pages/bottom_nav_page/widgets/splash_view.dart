import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

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
              Values.kSplashImage,
              width: 160.0,
              height: 160.0,
            ),
            const SizedBox(height: 32.0),
            BallRotateIndicator(),
          ],
        ),
      ),
    );
  }
}