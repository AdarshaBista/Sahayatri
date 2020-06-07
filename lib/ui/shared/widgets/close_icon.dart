import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class CloseIcon extends StatelessWidget {
  final IconData iconData;

  const CloseIcon({
    this.iconData = Icons.close,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.repository<DestinationNavService>().pop(),
      child: ScaleAnimator(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: AppColors.dark,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: AppColors.background,
          ),
        ),
      ),
    );
  }
}
