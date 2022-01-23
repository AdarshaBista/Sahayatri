import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/images.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class UnauthenticatedIndicator extends StatelessWidget {
  const UnauthenticatedIndicator();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      imageUrl: Images.unauthenticated,
      title: Text(
        'Your are not logged in.',
        textAlign: TextAlign.center,
        style: context.t.headline5?.bold,
      ),
    );
  }
}
