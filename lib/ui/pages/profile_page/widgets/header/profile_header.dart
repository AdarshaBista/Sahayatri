import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/user_avatar.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/user_email.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/header/logout_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return SliverAppBar(
      pinned: true,
      elevation: 8.0,
      expandedHeight: UiConfig.profileHeaderHeight,
      automaticallyImplyLeading: false,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: LogoutButton(),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: _buildContent(context, user),
        collapseMode: CollapseMode.pin,
        title: Text(
          user.name.toUpperCase(),
          style: context.t.headline4.bold,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, User user) {
    return Stack(
      children: [
        if (user.imageUrl != null) _buildBlurredImage(user.imageUrl),
        if (user.imageUrl != null) _buildGradient(context),
        _buildForeground(),
      ],
    );
  }

  Widget _buildForeground() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          UserAvatar(),
          SizedBox(height: 16.0),
          UserEmail(),
          SizedBox(height: 48.0),
        ],
      ),
    );
  }

  Widget _buildGradient(BuildContext context) {
    return GradientContainer(
      gradientBegin: Alignment.topCenter,
      gradientEnd: Alignment.bottomCenter,
      gradientColors: AppColors.getCollapsibleHeaderGradient(context),
    );
  }

  Widget _buildBlurredImage(String imageUrl) {
    return ClipRRect(
      child: Container(
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
}
