import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;

  const StatCard({
    @required this.label,
    @required this.count,
    @required this.color,
  })  : assert(label != null),
        assert(count != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: AutoSizeText(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.small.bold,
            ),
          ),
          const SizedBox(height: 6.0),
          Flexible(
            child: AutoSizeText(
              count,
              style: AppTextStyles.large.bold.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
