import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';

class SourceSheet extends StatelessWidget {
  final void Function(ImageSource) onSelect;

  const SourceSheet({
    @required this.onSelect,
  }) : assert(onSelect != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Update avatar',
            style: AppTextStyles.small.bold,
          ),
          const SizedBox(height: 8.0),
          CustomButton(
            label: 'GALLERY',
            color: AppColors.dark,
            iconData: Icons.photo_album_outlined,
            backgroundColor: AppColors.primaryLight,
            onTap: () => onSelect(ImageSource.gallery),
          ),
          CustomButton(
            label: 'CAMERA',
            color: AppColors.dark,
            iconData: Icons.camera_alt_outlined,
            backgroundColor: AppColors.primaryLight,
            onTap: () => onSelect(ImageSource.camera),
          ),
        ],
      ),
    );
  }
}
