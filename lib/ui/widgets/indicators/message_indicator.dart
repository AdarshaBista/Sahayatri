import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class MessageIndicator extends StatelessWidget {
  final String message;

  const MessageIndicator({
    @required this.message,
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Images.message,
      title: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.small.bold,
      ),
    );
  }
}
