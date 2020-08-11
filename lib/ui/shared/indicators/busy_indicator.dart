import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/simple_busy_indicator.dart';

class BusyIndicator extends StatelessWidget {
  const BusyIndicator();

  @override
  Widget build(BuildContext context) {
    return const IconIndicator(
      imageUrl: Images.kLoading,
      title: Center(
        child: SimpleBusyIndicator(),
      ),
    );
  }
}
