import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/simple_busy_indicator.dart';

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
            const SimpleBusyIndicator(color: AppColors.light),
          ],
        ),
      ),
    );
  }
}
