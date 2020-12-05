import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class CustomTile extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final Widget trailing;
  final VoidCallback onTap;
  final TextStyle textStyle;

  const CustomTile({
    this.color,
    this.textStyle,
    @required this.icon,
    @required this.title,
    @required this.onTap,
    this.trailing,
  })  : assert(icon != null),
        assert(title != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: color,
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        onTap: onTap,
        trailing: trailing,
        title: Row(
          children: [
            Icon(
              icon,
              size: 20.0,
              color: context.c.onSurface,
            ),
            const SizedBox(width: 16.0),
            Text(
              title,
              style: textStyle ?? context.t.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
