import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';

class TrackLocationButton extends StatelessWidget {
  final bool isTracking;
  final VoidCallback onTap;

  const TrackLocationButton({
    super.key,
    required this.onTap,
    required this.isTracking,
  });

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      onTap: onTap,
      icon: isTracking ? AppIcons.tracking : AppIcons.trackingOff,
    );
  }
}
