import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/simple_busy_indicator.dart';

class BusyIndicator extends StatelessWidget {
  const BusyIndicator();

  @override
  Widget build(BuildContext context) {
    return const IconIndicator(
      imageUrl: Images.loading,
      title: Center(
        child: SimpleBusyIndicator(),
      ),
    );
  }
}
