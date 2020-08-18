import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/source_sheet.dart';

class UserAvatar extends StatelessWidget {
  static const double kRadius = 80.0;

  const UserAvatar();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return GestureDetector(
      onTap: () => SourceSheet(
        onSelect: (source) => _updateAvatar(context, source),
      ).openModalBottomSheet(context),
      child: CircleAvatar(
        radius: kRadius + 2.0,
        backgroundColor: user.imageUrl == null ? AppColors.barrier : AppColors.light,
        child: CircleAvatar(
          radius: kRadius,
          backgroundColor: AppColors.primary,
          child: _buildImage(user),
        ),
      ),
    );
  }

  Widget _buildImage(User user) {
    return user.imageUrl == null
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
          );
  }

  Future<void> _updateAvatar(BuildContext context, ImageSource source) async {
    Navigator.of(context).pop();

    context.openSnackBar('Updating avatar...');
    final success = await context.bloc<UserCubit>().updateAvatar(source);
    if (success) {
      context.openSnackBar('Avatar updated.');
    } else {
      context.openSnackBar('Failed to update avatar.');
    }
  }
}
