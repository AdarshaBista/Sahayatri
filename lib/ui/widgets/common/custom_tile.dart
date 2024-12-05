import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  const CustomTile({
    super.key,
    this.onTap,
    this.color,
    this.iconColor,
    this.textStyle,
    this.trailing,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: color,
      child: ListTile(
        dense: true,
        onTap: onTap,
        trailing: trailing,
        visualDensity: VisualDensity.compact,
        title: IconLabel(
          icon: icon,
          label: title,
          gap: 16.0,
          iconSize: 20.0,
          iconColor: iconColor ?? context.c.onSurface,
          labelStyle: textStyle ?? context.t.headlineSmall,
        ),
      ),
    );
  }
}
