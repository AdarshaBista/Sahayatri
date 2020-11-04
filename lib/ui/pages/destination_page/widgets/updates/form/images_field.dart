import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';
import 'package:sahayatri/ui/widgets/common/photo_gallery.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/common/image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  const ImagesField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Images',
              style: AppTextStyles.small.bold,
            ),
            const SizedBox(height: 4.0),
            Text(
              '${state.imageUrls.length} images selected',
              style: AppTextStyles.extraSmall.primaryDark,
            ),
            const SizedBox(height: 6.0),
            PhotoGallery(
              imageUrls: state.imageUrls,
              onDelete: context.bloc<DestinationUpdateFormCubit>().removeImageUrl,
            ),
            if (state.imageUrls.length < ApiConfig.maxImages)
              CustomButton(
                label: 'Add Image',
                color: AppColors.dark,
                backgroundColor: AppColors.lightAccent,
                iconData: Icons.add_photo_alternate_outlined,
                onTap: () => ImageSourceSheet(
                  onSelect: context.bloc<DestinationUpdateFormCubit>().selectImage,
                ).openModalBottomSheet(context),
              ),
          ],
        );
      },
    );
  }
}
