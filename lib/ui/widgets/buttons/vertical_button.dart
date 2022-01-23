import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class VerticalButton extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const VerticalButton({
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  })  : assert(icon != null),
        assert(label != null);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.c.onBackground;

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
              color: effectiveColor,
            ),
            const SizedBox(height: 4.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.headline6.bold.withColor(effectiveColor),
            ),
          ],
        ),
      ),
    );
  }
}
