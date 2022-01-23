import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({
    required this.onPressed,
  }) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      expanded: false,
      onTap: onPressed,
      icon: AppIcons.confirm,
    );
  }
}
