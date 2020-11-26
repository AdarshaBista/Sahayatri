import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class CircularBusyIndicator extends StatelessWidget {
  final Color color;

  const CircularBusyIndicator({
    this.color = AppColors.primaryDark,
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 32.0,
        height: 32.0,
        child: LoadingIndicator(
          color: color,
          indicatorType: Indicator.ballSpinFadeLoader,
        ),
      ),
    );
  }
}
