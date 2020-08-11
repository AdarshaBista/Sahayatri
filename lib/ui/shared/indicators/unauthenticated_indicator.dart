import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class UnauthenticatedIndicator extends StatelessWidget {
  const UnauthenticatedIndicator();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Images.kUnauthenticated,
      title: Text(
        'Your are not logged in.',
        textAlign: TextAlign.center,
        style: AppTextStyles.small.bold,
      ),
    );
  }
}
