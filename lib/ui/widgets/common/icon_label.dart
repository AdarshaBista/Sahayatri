import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final double iconSize;
  final Color iconColor;
  final double gap;
  final TextStyle labelStyle;

  const IconLabel({
    required this.icon,
    required this.label,
    this.labelStyle,
    this.iconColor,
    this.gap = 4.0,
    this.iconSize = 12.0,
  })  : assert(gap != null),
        assert(icon != null),
        assert(label != null),
        assert(iconSize != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor ?? context.c.onBackground,
        ),
        SizedBox(width: gap),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: labelStyle ?? context.t.headline5.bold,
          ),
        ),
      ],
    );
  }
}
