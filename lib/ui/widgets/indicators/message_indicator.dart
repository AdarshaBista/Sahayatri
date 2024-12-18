import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/images.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class MessageIndicator extends StatelessWidget {
  final String message;
  final String imageUrl;

  const MessageIndicator({
    super.key,
    required this.message,
    this.imageUrl = Images.alert,
  });

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      padding: 0.0,
      imageUrl: imageUrl,
      title: Text(
        message,
        textAlign: TextAlign.center,
        style: context.t.headlineSmall?.bold,
      ),
    );
  }
}
