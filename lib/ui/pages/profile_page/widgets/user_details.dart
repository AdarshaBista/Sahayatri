import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class UserDetails extends StatelessWidget {
  const UserDetails();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          user.name.toUpperCase(),
          style: AppTextStyles.medium.bold,
        ),
        const SizedBox(height: 4.0),
        Text(
          user.email,
          style: AppTextStyles.extraSmall,
        ),
      ],
    );
  }
}
