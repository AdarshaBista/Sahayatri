import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/images.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class LocationErrorIndicator extends StatelessWidget {
  final String message;

  const LocationErrorIndicator({
    @required this.message,
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      padding: 32.0,
      imageUrl: Images.trackerUnavailable,
      title: Text(
        message,
        textAlign: TextAlign.center,
        style: context.t.headline5.bold,
      ),
    );
  }
}
