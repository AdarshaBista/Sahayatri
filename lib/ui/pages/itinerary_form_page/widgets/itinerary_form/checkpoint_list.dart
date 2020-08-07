import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/itinerary_timeline.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_form_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/checkpoint_form.dart';

class CheckpointList extends StatelessWidget {
  final List<Checkpoint> checkpoints;

  const CheckpointList({
    @required this.checkpoints,
  }) : assert(checkpoints != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Checkpoints', style: AppTextStyles.medium),
        const SizedBox(height: 8.0),
        CustomFormField<List<Checkpoint>>(
          initialValue: checkpoints,
          validator: FormValidators.checkpoints(),
          builder: (field) => _buildAddCheckpointButton(context),
        ),
        ItineraryTimeline(
          isNested: true,
          isEditable: true,
          checkpoints: checkpoints,
        ),
      ],
    );
  }

  Widget _buildAddCheckpointButton(BuildContext context) {
    return CustomButton(
      label: 'Add a Checkpoint',
      color: AppColors.dark,
      backgroundColor: AppColors.primary.withOpacity(0.4),
      iconData: CommunityMaterialIcons.map_marker_check,
      onTap: () {
        FocusScope.of(context).unfocus();
        CheckpointForm(
          checkpoint: null,
          onSubmit: (checkpoint) =>
              context.bloc<ItineraryFormCubit>().addCheckpoint(checkpoint),
        ).openModalBottomSheet(context);
      },
    );
  }
}
