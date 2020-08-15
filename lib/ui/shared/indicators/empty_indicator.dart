import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/retry_button.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';

class EmptyIndicator extends StatelessWidget {
  final VoidCallback onRetry;

  const EmptyIndicator({
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconIndicator(
          imageUrl: Images.kEmpty,
          title: Text(
            'Nothing to show...',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.bold,
          ),
        ),
        if (onRetry != null) RetryButton(onTap: onRetry),
      ],
    );
  }
}
