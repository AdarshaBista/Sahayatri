import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_text_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/duration_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/checkpoint_list.dart';

class ItineraryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItineraryFormBloc, ItineraryFormState>(
      builder: (context, state) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 64.0),
          children: [
            _buildNameField(state.name, context),
            const SizedBox(height: 16.0),
            _buildDurationField(state, context),
            const SizedBox(height: 16.0),
            CheckpointList(checkpoints: state.checkpoints),
          ],
        );
      },
    );
  }

  Widget _buildNameField(String name, BuildContext context) {
    return CustomTextField(
      label: 'Name',
      initialValue: name,
      validator: FormValidators.requiredText(),
      onChanged: (name) => context.bloc<ItineraryFormBloc>().add(NameChanged(name: name)),
    );
  }

  Widget _buildDurationField(ItineraryFormState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Duration',
          style: AppTextStyles.medium,
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Flexible(
              child: DurationField(
                label: 'Days',
                initialValue: state.days,
                onChanged: (days) =>
                    context.bloc<ItineraryFormBloc>().add(DaysChanged(days: days)),
              ),
            ),
            const SizedBox(width: 12.0),
            Flexible(
              child: DurationField(
                label: 'Nights',
                initialValue: state.nights,
                onChanged: (nights) =>
                    context.bloc<ItineraryFormBloc>().add(NightsChanged(nights: nights)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
