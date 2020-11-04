import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/retry_button.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorIndicator({
    this.onRetry,
    this.message = 'An error has occured!',
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconIndicator(
          imageUrl: Images.error,
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.small.bold,
          ),
        ),
        if (onRetry != null) RetryButton(onTap: onRetry),
      ],
    );
  }
}
