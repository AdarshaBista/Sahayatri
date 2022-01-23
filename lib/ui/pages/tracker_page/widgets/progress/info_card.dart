import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class InfoCard extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final String subtitle;

  const InfoCard({
    this.color = AppColors.primaryDark,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0,
      child: CustomCard(
        borderRadius: 12.0,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 18.0,
              color: color,
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.t.headline5?.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              subtitle,
              style: context.t.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
