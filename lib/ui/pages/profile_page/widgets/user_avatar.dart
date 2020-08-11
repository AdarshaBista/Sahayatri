import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return GradientContainer(
      gradientBegin: Alignment.bottomCenter,
      gradientEnd: Alignment.topCenter,
      gradientColors: [
        AppColors.primaryDark.withOpacity(0.8),
        AppColors.primaryDark.withOpacity(0.5),
        AppColors.primaryDark.withOpacity(0.2),
        Colors.transparent,
        Colors.transparent,
      ],
      child: user.imageUrl == null
          ? _buildDefaultAvatar(user.name)
          : Image.asset(
              user.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Center(
      child: CircleAvatar(
        radius: 90.0,
        backgroundColor: AppColors.primary.withOpacity(0.4),
        child: Text(
          name[0],
          style: AppTextStyles.medium.withSize(90.0).withColor(AppColors.primaryDark),
        ),
      ),
    );
  }
}
