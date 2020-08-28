import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/user_avatar.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/user_details.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/logout_button.dart';

class ProfileHeader extends StatelessWidget {
  static const double kHeaderHeight = 300.0;

  const ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return Container(
      height: kHeaderHeight,
      child: Stack(
        children: [
          if (user.imageUrl != null) _buildBlurredImage(user.imageUrl),
          if (user.imageUrl != null) _buildGradient(),
          _buildLogoutButton(),
          _buildForeground(),
        ],
      ),
    );
  }

  Widget _buildForeground() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          UserAvatar(),
          SizedBox(height: 16.0),
          UserDetails(),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildGradient() {
    return GradientContainer(
      gradientColors: [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        AppColors.light.withOpacity(0.2),
        AppColors.light.withOpacity(0.7),
        AppColors.light,
      ],
    );
  }

  Widget _buildBlurredImage(String imageUrl) {
    return ClipRRect(
      child: Container(
        height: kHeaderHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 2.0),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return const Positioned(
      top: 12.0,
      right: 12.0,
      child: LogoutButton(),
    );
  }
}
