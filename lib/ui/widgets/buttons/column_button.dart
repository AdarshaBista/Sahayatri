import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class ColumnButton extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ColumnButton({
    @required this.icon,
    @required this.label,
    this.color = AppColors.dark,
    this.onTap,
  })  : assert(icon != null),
        assert(color != null),
        assert(label != null);

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
              color: color,
            ),
            const SizedBox(height: 4.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.extraSmall.bold.withColor(color),
            ),
          ],
        ),
      ),
    );
  }
}
