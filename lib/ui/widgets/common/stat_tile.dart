import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';

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
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        title: Text(
          label,
          style: context.t.headline5.bold,
        ),
        leading: Icon(
          icon,
          size: 20.0,
          color: context.c.onSurface,
        ),
        trailing: Text(
          stat,
          style: context.t.headline4,
        ),
      ),
    );
  }
}
