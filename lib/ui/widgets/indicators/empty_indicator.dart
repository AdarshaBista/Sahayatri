import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/images.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/retry_button.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class EmptyIndicator extends StatelessWidget {
  final String message;
  final String imageUrl;
  final double padding;
  final VoidCallback? onRetry;

  const EmptyIndicator({
    super.key,
    this.padding = 64.0,
    this.message = 'Nothing to show...',
    this.imageUrl = Images.generalEmpty,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconIndicator(
            padding: padding,
            imageUrl: imageUrl,
            title: Text(
              message,
              textAlign: TextAlign.center,
              style: context.t.headlineSmall?.bold,
            ),
          ),
          if (onRetry != null) RetryButton(onTap: onRetry),
        ],
      ),
    );
  }
}
