import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/common/image_source_sheet.dart';

class UserAvatar extends StatelessWidget {
  static const double radius = 80.0;

  const UserAvatar();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return GestureDetector(
      onTap: () => ImageSourceSheet(
        onSelect: (source) => _updateAvatar(context, source),
      ).openModalBottomSheet(context),
      child: ScaleAnimator(
        child: CircleAvatar(
          radius: radius + 2.0,
          backgroundColor: context.c.surface,
          child: CircleAvatar(
            radius: radius,
            child: _buildImage(user),
            backgroundColor: context.c.background,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(User user) {
    return user.imageUrl == null
        ? const Icon(
            AppIcons.edit,
            size: 24.0,
            color: AppColors.darkAccent,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: AdaptiveImage(user.imageUrl),
          );
  }

  Future<void> _updateAvatar(BuildContext context, ImageSource source) async {
    Navigator.of(context).pop();

    bool success;
    await context.openLoadingFlushBar(
      'Updating avatar...',
      callback: () async {
        success = await context.read<UserCubit>().updateAvatar(source);
      },
    );
    if (success) {
      context.openFlushBar('Avatar updated.', type: FlushbarType.success);
    } else {
      context.openFlushBar('Failed to update avatar.', type: FlushbarType.error);
    }
  }
}
