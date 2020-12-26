import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/images.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

class SplashView extends StatelessWidget {
  const SplashView();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Images.splash,
                  width: 160.0,
                  height: 160.0,
                ),
                const SizedBox(height: 32.0),
                const CircularBusyIndicator(color: AppColors.light),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
