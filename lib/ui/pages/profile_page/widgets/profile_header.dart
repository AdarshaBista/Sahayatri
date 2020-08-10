import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/logout_button.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _buildAvatar(context),
          _buildDetails(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
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

  Widget _buildDetails(BuildContext context) {
    final user = context.watch<User>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name.toUpperCase(),
            style: AppTextStyles.medium.bold,
          ),
          const SizedBox(height: 4.0),
          Text(
            user.email,
            style: AppTextStyles.small,
          ),
          const LogoutButton(),
        ],
      ),
    );
  }
}
