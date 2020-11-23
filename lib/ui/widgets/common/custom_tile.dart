import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  final VoidCallback onTap;

  const CustomTile({
    @required this.icon,
    @required this.onTap,
    @required this.title,
    this.trailing,
  })  : assert(icon != null),
        assert(onTap != null),
        assert(title != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        onTap: onTap,
        trailing: trailing,
        title: Row(
          children: [
            Icon(
              icon,
              size: 20.0,
              color: AppColors.darkFaded,
            ),
            const SizedBox(width: 16.0),
            Text(
              title,
              style: AppTextStyles.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
