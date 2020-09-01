import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class UserEmail extends StatelessWidget {
  const UserEmail();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return SlideAnimator(
      begin: const Offset(0.0, 0.5),
      child: Container(
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
    );
  }
}
