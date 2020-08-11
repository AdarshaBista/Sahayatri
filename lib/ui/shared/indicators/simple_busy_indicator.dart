import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SimpleBusyIndicator extends StatelessWidget {
  final Color color;

  const SimpleBusyIndicator({
    this.color = AppColors.primary,
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.0,
      height: 32.0,
      child: LoadingIndicator(
        color: color,
        indicatorType: Indicator.ballPulse,
      ),
    );
  }
}
