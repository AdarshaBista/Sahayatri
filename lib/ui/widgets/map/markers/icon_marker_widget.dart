import 'package:flutter/material.dart';

class IconMarkerWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const IconMarkerWidget({
    this.onTap,
    required this.icon,
    required this.color,
  })  : assert(icon != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 28.0,
        color: color,
      ),
    );
  }
}
