import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ScanIndicator extends StatelessWidget {
  const ScanIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      padding: const EdgeInsets.all(16.0),
      child: const LoadingIndicator(
        colors: [AppColors.primary],
        indicatorType: Indicator.ballScaleMultiple,
      ),
    );
  }
}
