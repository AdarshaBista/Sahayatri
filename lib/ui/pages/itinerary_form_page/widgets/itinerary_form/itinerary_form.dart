import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/form/custom_text_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/duration_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/checkpoint_list.dart';

class ItineraryForm extends StatelessWidget {
  const ItineraryForm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItineraryFormCubit, ItineraryFormState>(
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
      icon: AppIcons.mountain,
      validator: FormValidators.requiredText('Please enter a name.'),
      onChanged: (name) => context.read<ItineraryFormCubit>().changeName(name),
    );
  }

  Widget _buildDurationField(ItineraryFormState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Duration',
          style: context.t.headline5.bold,
        ),
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: DurationField(
                label: 'Days',
                initialValue: state.days,
                icon: AppIcons.day,
                onChanged: (days) => context.read<ItineraryFormCubit>().changeDays(days),
              ),
            ),
            const SizedBox(width: 12.0),
            Flexible(
              child: DurationField(
                label: 'Nights',
                initialValue: state.nights,
                icon: AppIcons.night,
                onChanged: (nights) =>
                    context.read<ItineraryFormCubit>().changeNights(nights),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
