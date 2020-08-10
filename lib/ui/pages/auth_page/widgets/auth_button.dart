import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const AuthButton({
    @required this.label,
    @required this.icon,
    @required this.onPressed,
  })  : assert(label != null),
        assert(icon != null),
        assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: '${label}Tag',
      icon: Icon(icon),
      onPressed: onPressed,
      label: Text(
        label,
        style: AppTextStyles.small.bold.primary,
      ),
    );
  }
}
