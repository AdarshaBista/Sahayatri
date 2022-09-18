import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/extensions/flushbar_extension.dart';
import 'package:sahayatri/core/models/user.dart';

import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/image/image_source_sheet.dart';

class UserAvatar extends StatefulWidget {
  static const double radius = 80.0;

  const UserAvatar({super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return GestureDetector(
      onTap: () => ImageSourceSheet(
        onSelect: (source) => _updateAvatar(context, source),
      ).openModalBottomSheet(context),
      child: ScaleAnimator(
        child: CircleAvatar(
          radius: UserAvatar.radius + 2.0,
          backgroundColor: context.c.surface,
          child: CircleAvatar(
            radius: UserAvatar.radius,
            child: _buildImage(user),
            backgroundColor: context.c.background,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(User user) {
    return !user.hasImage
        ? const Icon(
            AppIcons.edit,
            size: 24.0,
            color: AppColors.darkAccent,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(UserAvatar.radius),
            child: AdaptiveImage(user.imageUrl),
          );
  }

  Future<void> _updateAvatar(BuildContext context, ImageSource source) async {
    Navigator.of(context).pop();

    final success = await context.openLoadingFlushBar<bool>(
      'Updating avatar...',
      callback: () => context.read<UserCubit>().updateAvatar(source),
    );
    if (!mounted) return;

    if (success) {
      context.openFlushBar(
        'Avatar updated.',
        type: FlushbarType.success,
      );
    } else {
      context.openFlushBar(
        'Failed to update avatar.',
        type: FlushbarType.error,
      );
    }
  }
}
