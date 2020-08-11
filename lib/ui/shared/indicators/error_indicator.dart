import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

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
          imageUrl: Images.kError,
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.medium,
          ),
        ),
        if (onRetry != null)
          CustomButton(
            label: 'Retry',
            outlineOnly: true,
            iconData: Icons.refresh,
            color: AppColors.dark,
            onTap: onRetry,
          ),
      ],
    );
  }
}
