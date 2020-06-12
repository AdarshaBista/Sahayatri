import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsCard({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.onTap,
  })  : assert(title != null),
        assert(subtitle != null),
        assert(icon != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        isThreeLine: true,
        onTap: onTap,
        title: Text(
          title,
          style: AppTextStyles.medium.bold,
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.extraSmall,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.4),
          child: Icon(
            icon,
            color: AppColors.dark,
          ),
        ),
      ),
    );
  }
}
