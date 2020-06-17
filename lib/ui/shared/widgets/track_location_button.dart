import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

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
    return SlideAnimator(
      begin: const Offset(2.0, 0.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: AppColors.dark,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isTracking ? Icons.my_location : Icons.location_disabled,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
