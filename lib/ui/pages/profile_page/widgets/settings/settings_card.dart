import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: ElevatedCard(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.3),
              child: Icon(
                icon,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(width: 16.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.small.bold,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    subtitle,
                    maxLines: 2,
                    style: AppTextStyles.extraSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
