import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:sahayatri/ui/pages/destination_page/widgets/updates/update_map_dialog.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_tile.dart';

class LocationField extends StatelessWidget {
  const LocationField({super.key});

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
              style: context.t.headlineSmall?.bold,
            ),
            const SizedBox(height: 4.0),
            Text(
              '${state.coords.length} locations',
              style: AppTextStyles.headline6.primaryDark,
            ),
            const SizedBox(height: 6.0),
            CustomTile(
              title: 'View / Select Locations',
              icon: AppIcons.addLocation,
              onTap: () {
                FocusScope.of(context).unfocus();
                BlocProvider<DestinationUpdateFormCubit>.value(
                  value: context.read<DestinationUpdateFormCubit>(),
                  child: const UpdateMapDialog(),
                ).openDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
