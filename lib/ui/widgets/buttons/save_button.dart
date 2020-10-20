import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({
    @required this.onPressed,
  }) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48.0,
        width: 72.0,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
            child: Text(
          'SAVE',
          style: AppTextStyles.small.primaryDark.bold,
        )),
      ),
    );
  }
}
