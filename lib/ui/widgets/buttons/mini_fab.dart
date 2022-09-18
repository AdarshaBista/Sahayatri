import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class MiniFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MiniFab({
    super.key,
    required this.onTap,
    this.icon = AppIcons.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: onTap,
      child: Icon(
        icon,
        size: 22.0,
      ),
    );
  }
}
