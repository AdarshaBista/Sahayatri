import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/column_button.dart';

class SquareButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  const SquareButton({
    this.color,
    this.backgroundColor,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  })  : assert(icon != null),
        assert(label != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryLight,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: ColumnButton(
            label: label,
            icon: icon,
            color: color,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
