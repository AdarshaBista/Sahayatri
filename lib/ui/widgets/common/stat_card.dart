import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle? countStyle;

  const StatCard({
    required this.label,
    required this.count,
    required this.color,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.countStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: context.t.headline6?.bold,
            ),
          ),
          const SizedBox(height: 3.0),
          Container(
            height: 1.0,
            width: 24.0,
            color: context.c.surface,
          ),
          const SizedBox(height: 6.0),
          Flexible(
            child: Text(
              count,
              textAlign: TextAlign.center,
              style: countStyle?.withColor(color) ??
                  AppTextStyles.headline4.bold.withColor(color),
            ),
          ),
        ],
      ),
    );
  }
}
