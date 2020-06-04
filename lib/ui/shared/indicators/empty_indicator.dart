import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Values.kEmptyImage,
      title: Text(
        'Nothing to show',
        textAlign: TextAlign.center,
        style: AppTextStyles.medium,
      ),
    );
  }
}
