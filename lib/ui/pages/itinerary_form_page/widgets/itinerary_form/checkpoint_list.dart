import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/itinerary_timeline.dart';
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
        Text(
          'Checkpoints',
          style: AppTextStyles.medium,
        ),
        const SizedBox(height: 8.0),
        _buildAddCheckpointButton(context),
        const Divider(height: 24.0),
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
      outlineOnly: true,
      color: AppColors.dark,
      iconData: CommunityMaterialIcons.map_marker_check,
      onTap: () {
        FocusScope.of(context).unfocus();
        CheckpointForm(
          checkpoint: null,
          onSubmit: (checkpoint) => context
              .bloc<ItineraryFormBloc>()
              .add(CheckpointAdded(checkpoint: checkpoint)),
        ).openModalBottomSheet(context);
      },
    );
  }
}
