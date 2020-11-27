import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/images.dart';

import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

class BusyIndicator extends StatelessWidget {
  final String imageUrl;
  final double padding;

  const BusyIndicator({
    this.padding = 64.0,
    this.imageUrl = Images.generalLoading,
  })  : assert(padding != null),
        assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconIndicator(
        padding: padding,
        imageUrl: imageUrl,
        title: const CircularBusyIndicator(),
      ),
    );
  }
}
