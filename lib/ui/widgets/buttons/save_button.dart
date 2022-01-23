import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SaveButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      expanded: false,
      onTap: onPressed,
      icon: AppIcons.confirm,
    );
  }
}
