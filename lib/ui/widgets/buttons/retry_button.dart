import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onTap;

  const RetryButton({
    @required this.onTap,
  }) : assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      label: 'Retry',
      iconData: Icons.refresh,
      color: AppColors.secondary,
      backgroundColor: Colors.transparent,
    );
  }
}
