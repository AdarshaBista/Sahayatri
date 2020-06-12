import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class ColumnButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ColumnButton({
    @required this.icon,
    @required this.label,
    @required this.onTap,
  })  : assert(icon != null),
        assert(label != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ScaleAnimator(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.0,
            ),
            const SizedBox(height: 4.0),
            Text(
              label,
              style: AppTextStyles.extraSmall.bold,
            ),
          ],
        ),
      ),
    );
  }
}
