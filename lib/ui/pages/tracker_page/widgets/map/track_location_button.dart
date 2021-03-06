import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';

class TrackLocationButton extends StatelessWidget {
  final bool isTracking;
  final VoidCallback onTap;

  const TrackLocationButton({
    @required this.onTap,
    @required this.isTracking,
  })  : assert(onTap != null),
        assert(isTracking != null);

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      onTap: onTap,
      icon: isTracking ? AppIcons.tracking : AppIcons.trackingOff,
    );
  }
}
