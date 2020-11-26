import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/retry_button.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final String imageUrl;

  const ErrorIndicator({
    this.onRetry,
    this.imageUrl = Images.generalError,
    this.message = 'An error has occured!',
  })  : assert(message != null),
        assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconIndicator(
            imageUrl: imageUrl,
            title: Text(
              message,
              textAlign: TextAlign.center,
              style: context.t.headline5.bold,
            ),
          ),
          if (onRetry != null) RetryButton(onTap: onRetry),
        ],
      ),
    );
  }
}
