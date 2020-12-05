import 'package:flutter/material.dart';

class MiniFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MiniFab({
    @required this.onTap,
    this.icon = Icons.check,
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
