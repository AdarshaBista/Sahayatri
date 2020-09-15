import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_post_cubit/destination_update_post_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  const ImagesField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdatePostCubit, DestinationUpdatePostState>(
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
            CustomButton(
              label: 'Add Image',
              color: AppColors.primaryDark,
              backgroundColor: AppColors.primaryLight,
              iconData: Icons.add_photo_alternate_outlined,
              onTap: () => ImageSourceSheet(
                onSelect: context.bloc<DestinationUpdatePostCubit>().selectImage,
              ).openModalBottomSheet(context),
            ),
          ],
        );
      },
    );
  }
}
