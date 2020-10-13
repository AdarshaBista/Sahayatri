import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class CircularBusyIndicator extends StatelessWidget {
  const CircularBusyIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 32.0,
        height: 32.0,
        child: LoadingIndicator(
          color: AppColors.primary,
          indicatorType: Indicator.ballSpinFadeLoader,
        ),
      ),
    );
  }
}
