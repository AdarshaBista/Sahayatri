import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;

  const ErrorIndicator({
    this.message = 'An error has occured!',
  });

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Values.kErrorImage,
      title: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.medium,
      ),
    );
  }
}
