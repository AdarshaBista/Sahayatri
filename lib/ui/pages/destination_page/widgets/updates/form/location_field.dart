import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/select_location_dialog.dart';

class LocationField extends StatelessWidget {
  const LocationField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Location',
              style: AppTextStyles.small.bold,
            ),
            const SizedBox(height: 4.0),
            Text(
              '${state.coords.length} locations selected',
              style: AppTextStyles.extraSmall.primaryDark,
            ),
            CustomButton(
              label: 'View / Select Locations',
              color: AppColors.dark,
              backgroundColor: AppColors.lightAccent,
              iconData: CommunityMaterialIcons.map_marker_plus_outline,
              onTap: () => BlocProvider<DestinationUpdateFormCubit>.value(
                value: context.bloc<DestinationUpdateFormCubit>(),
                child: const SelectLocationDialog(),
              ).openDialog(context),
            ),
          ],
        );
      },
    );
  }
}
