import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class UserDetails extends StatelessWidget {
  const UserDetails();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return SlideAnimator(
      begin: const Offset(0.0, 0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            user.name.toUpperCase(),
            style: AppTextStyles.large.bold,
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: AppColors.dark,
                width: 0.5,
              ),
            ),
            child: Text(
              user.email,
              style: AppTextStyles.extraSmall,
            ),
          ),
        ],
      ),
    );
  }
}
