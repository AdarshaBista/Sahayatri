import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ScanIndicator extends StatelessWidget {
  const ScanIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      padding: const EdgeInsets.all(16.0),
      child: LoadingIndicator(
        color: AppColors.primary,
        indicatorType: Indicator.ballScaleMultiple,
      ),
    );
  }
}
