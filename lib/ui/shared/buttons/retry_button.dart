import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onTap;

  const RetryButton({
    @required this.onTap,
  }) : assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.0,
      backgroundColor: AppColors.primaryLight,
      child: IconButton(
        onPressed: onTap,
        splashRadius: 20.0,
        icon: Icon(
          Icons.refresh_outlined,
          color: AppColors.barrier,
        ),
      ),
    );
  }
}
