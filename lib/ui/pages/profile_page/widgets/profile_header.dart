import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/user_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          const UserAvatar(),
          _buildDetails(context),
        ],
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
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: context.bloc<AuthCubit>().logout,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          'LOGOUT',
          style: AppTextStyles.small.light,
        ),
      ),
    );
  }
}
