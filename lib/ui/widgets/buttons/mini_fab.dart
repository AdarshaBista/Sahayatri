import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class MiniFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MiniFab({
    @required this.onTap,
    this.icon = AppIcons.confirm,
  })  : assert(icon != null),
        assert(onTap != null);

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
