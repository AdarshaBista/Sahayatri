import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';

class ExitButton extends StatelessWidget {
  final double size;
  final Color color;
  final IconData icon;
  final Color backgroundColor;

  const ExitButton({
    this.size = 18.0,
    this.icon = AppIcons.close,
    this.color = AppColors.light,
    this.backgroundColor = AppColors.dark,
  });

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      onTap: Navigator.of(context).pop,
      icon: icon,
      size: size,
      color: color,
      backgroundColor: backgroundColor,
    );
  }
}
