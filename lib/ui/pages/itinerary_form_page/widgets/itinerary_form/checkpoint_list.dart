import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/checkpoint_form.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/itinerary_timeline.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/forms/custom_form_field.dart';

class CheckpointList extends StatelessWidget {
  final List<Checkpoint> checkpoints;

  const CheckpointList({
    super.key,
    required this.checkpoints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Checkpoints', style: context.t.headlineSmall?.bold),
        const SizedBox(height: 8.0),
        CustomFormField<List<Checkpoint>>(
          initialValue: checkpoints,
          validator: FormValidators.checkpoints().call,
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
      icon: AppIcons.addCheckpoint,
      onTap: () {
        FocusScope.of(context).unfocus();
        CheckpointForm(
          checkpoint: null,
          onSubmit: (checkpoint) => context.read<ItineraryFormCubit>().addCheckpoint(checkpoint),
        ).openModalBottomSheet(context, enableDrag: false);
      },
    );
  }
}
