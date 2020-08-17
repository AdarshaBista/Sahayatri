import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar();

  @override
  Widget build(BuildContext context) {
    const double kRadius = 80.0;
    final user = context.watch<User>();

    return CircleAvatar(
      radius: kRadius + 3.0,
      backgroundColor: AppColors.barrier,
      child: CircleAvatar(
        radius: kRadius,
        backgroundColor: AppColors.primary,
        child: user.imageUrl == null
            ? Text(
                user.name[0],
                style: AppTextStyles.medium.withSize(kRadius).darkAccent,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(kRadius),
                child: Image.network(
                  user.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
      ),
    );
  }
}
