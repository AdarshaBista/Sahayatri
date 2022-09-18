import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class DragIndicatorPill extends StatelessWidget {
  final Color? color;

  const DragIndicatorPill({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        height: 5.0,
        width: 32.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color ?? context.c.onBackground.withOpacity(0.25),
        ),
      ),
    );
  }
}
