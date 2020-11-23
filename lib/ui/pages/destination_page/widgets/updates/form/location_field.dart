import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_tile.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/select_location_dialog.dart';

class LocationField extends StatelessWidget {
  const LocationField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      buildWhen: (p, c) => p.coords.length != c.coords.length,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Locations',
              style: context.t.headline5.bold,
            ),
            const SizedBox(height: 4.0),
            Text(
              '${state.coords.length} locations',
              style: AppTextStyles.headline6.primaryDark,
            ),
            const SizedBox(height: 6.0),
            CustomTile(
              title: 'View / Select Locations',
              icon: CommunityMaterialIcons.map_marker_plus_outline,
              onTap: () => BlocProvider<DestinationUpdateFormCubit>.value(
                value: context.read<DestinationUpdateFormCubit>(),
                child: const SelectLocationDialog(),
              ).openDialog(context),
            ),
          ],
        );
      },
    );
  }
}
