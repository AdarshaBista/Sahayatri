import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_tile.dart';
import 'package:sahayatri/ui/widgets/image/photo_gallery.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/image/image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  const ImagesField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      buildWhen: (p, c) => p.imageUrls.length != c.imageUrls.length,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Images',
              style: context.t.headline5?.bold,
            ),
            const SizedBox(height: 4.0),
            Text(
              '${state.imageUrls.length} / ${ApiConfig.maxImages} images',
              style: state.imageUrls.length == ApiConfig.maxImages
                  ? AppTextStyles.headline6.secondary
                  : AppTextStyles.headline6.primaryDark,
            ),
            const SizedBox(height: 6.0),
            PhotoGallery(
              imageUrls: state.imageUrls,
              onDelete: (url) => context
                  .read<DestinationUpdateFormCubit>()
                  .removeImageUrl(url),
            ),
            if (state.imageUrls.isNotEmpty) const SizedBox(height: 8.0),
            if (state.imageUrls.length < ApiConfig.maxImages)
              ScaleAnimator(
                duration: 200,
                child: CustomTile(
                  title: 'Add Images',
                  icon: AppIcons.addPhoto,
                  onTap: () {
                    ImageSourceSheet(
                      onSelect: (source) {
                        Navigator.of(context).pop();
                        context
                            .read<DestinationUpdateFormCubit>()
                            .selectImage(source);
                      },
                    ).openModalBottomSheet(context);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
