import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/common/image_source_sheet.dart';

class UserAvatar extends StatelessWidget {
  static const double kRadius = 80.0;

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
          radius: kRadius + 2.0,
          backgroundColor: user.imageUrl == null ? AppColors.barrier : AppColors.light,
          child: CircleAvatar(
            radius: kRadius,
            backgroundColor: AppColors.primary,
            child: _buildImage(user),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(User user) {
    return user.imageUrl == null
        ? const Icon(
            Icons.edit_outlined,
            size: 24.0,
            color: AppColors.darkAccent,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(kRadius),
            child: AdaptiveImage(user.imageUrl),
          );
  }

  Future<void> _updateAvatar(BuildContext context, ImageSource source) async {
    Navigator.of(context).pop();

    context.openFlushBar('Updating avatar...');
    final success = await context.bloc<UserCubit>().updateAvatar(source);
    if (success) {
      context.openFlushBar('Avatar updated.', type: FlushBarType.success);
    } else {
      context.openFlushBar('Failed to update avatar.', type: FlushBarType.error);
    }
  }
}
