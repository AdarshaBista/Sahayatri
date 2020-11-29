import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:sahayatri/ui/widgets/common/sheet_header.dart';
import 'package:sahayatri/ui/widgets/buttons/square_button.dart';

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
          SheetHeader(
            title: 'Select image from',
            showDivider: false,
            onClose: Navigator.of(context).pop,
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              SquareButton(
                label: 'GALLERY',
                icon: Icons.photo_album_outlined,
                onTap: () => onSelect(ImageSource.gallery),
              ),
              const SizedBox(width: 12.0),
              SquareButton(
                label: 'CAMERA',
                icon: Icons.camera_alt_outlined,
                onTap: () => onSelect(ImageSource.camera),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
