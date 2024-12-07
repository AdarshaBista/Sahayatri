import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class IconLabel extends StatelessWidget {
  final double gap;
  final IconData icon;
  final String label;
  final double iconSize;
  final Color? iconColor;
  final TextStyle? labelStyle;

  const IconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.labelStyle,
    this.iconColor,
    this.gap = 4.0,
    this.iconSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor ?? context.c.onSurface,
        ),
        SizedBox(width: gap),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: labelStyle ?? context.t.headlineSmall?.bold,
          ),
        ),
      ],
    );
  }
}
