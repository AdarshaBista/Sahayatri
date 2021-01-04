import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';

import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';

class ImageSourceSheet extends StatelessWidget {
  final void Function(ImageSource) onSelect;

  const ImageSourceSheet({
    @required this.onSelect,
  }) : assert(onSelect != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Header(
            title: 'Select image from',
            fontSize: 20.0,
          ),
          const SizedBox(height: 12.0),
          CustomButton(
            label: 'GALLERY',
            icon: Icons.photo_album_outlined,
            onTap: () => onSelect(ImageSource.gallery),
          ),
          const SizedBox(height: 8.0),
          CustomButton(
            label: 'CAMERA',
            icon: Icons.camera_alt_outlined,
            onTap: () => onSelect(ImageSource.camera),
          ),
        ],
      ),
    );
  }
}
