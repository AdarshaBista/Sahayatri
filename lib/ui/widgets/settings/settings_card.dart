import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

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
      child: SlideAnimator(
        begin: const Offset(0.0, 0.5),
        child: ElevatedCard(
          color: context.theme.cardColor,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Icon(
                  icon,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.t.headline5.bold,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      maxLines: 2,
                      style: context.t.headline6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
