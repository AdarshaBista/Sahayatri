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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: AppTextStyles.headline5.light.bold,
            ),
            const SizedBox(width: 16.0),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: AppColors.light,
              ),
              child: Icon(
                icon,
                size: 18.0,
                color: AppColors.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
