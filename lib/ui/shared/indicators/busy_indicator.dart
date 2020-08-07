import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class BusyIndicator extends StatelessWidget {
  const BusyIndicator();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Images.kLoading,
      title: Center(
        child: SizedBox(
          width: 32.0,
          height: 32.0,
          child: LoadingIndicator(
            color: AppColors.primary,
            indicatorType: Indicator.ballPulse,
          ),
        ),
      ),
    );
  }
}
