import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class StatTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String stat;

  const StatTile({
    @required this.icon,
    @required this.stat,
    @required this.label,
  })  : assert(icon != null),
        assert(stat != null),
        assert(label != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(
          label,
          style: AppTextStyles.small,
        ),
        leading: Icon(
          icon,
          size: 22.0,
        ),
        trailing: Text(
          stat,
          style: AppTextStyles.medium.bold,
        ),
      ),
    );
  }
}
