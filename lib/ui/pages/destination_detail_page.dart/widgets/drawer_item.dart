import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItem({
    @required this.icon,
    @required this.label,
    @required this.onTap,
  })  : assert(icon != null),
        assert(label != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(
        icon,
        size: 20.0,
        color: AppColors.light,
      ),
      title: Text(
        label,
        style: AppTextStyles.headline5.light.bold,
      ),
    );
  }
}
