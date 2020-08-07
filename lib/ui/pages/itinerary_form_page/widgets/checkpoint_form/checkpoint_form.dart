import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/checkpoint_form_cubit/checkpoint_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_text_field.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_form_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/place_picker.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/date_time_picker.dart';

class CheckpointForm extends StatelessWidget {
  final Checkpoint checkpoint;
  final Function(Checkpoint) onSubmit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CheckpointForm({
    @required this.onSubmit,
    @required this.checkpoint,
  }) : assert(onSubmit != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckpointFormCubit>(
      create: (_) => CheckpointFormCubit(checkpoint: checkpoint),
      child: AnimatedPadding(
        curve: Curves.decelerate,
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 200),
        child: BlocBuilder<CheckpointFormCubit, CheckpointFormState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                children: [
                  Text(
                    checkpoint == null ? 'Create a Checkpoint' : 'Edit this checkpoint',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium.bold,
                  ),
                  const Divider(height: 24.0),
                  _buildPlaceField(state.place, context),
                  const SizedBox(height: 16.0),
                  _buildDateTimeField(state.dateTime, context),
                  const SizedBox(height: 16.0),
                  _buildDescriptionField(state.description, context),
                  const SizedBox(height: 16.0),
                  _buildSubmitButton(state, context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlaceField(Place place, BuildContext context) {
    return CustomFormField<Place>(
      initialValue: place,
      validator: FormValidators.nonNull('Please select a place.'),
      builder: (field) => PlacePicker(
        initialPlace: place,
        onSelect: (selectedPlace) {
          field.didChange(selectedPlace);
          context.bloc<CheckpointFormCubit>().changePlace(selectedPlace);
        },
      ),
    );
  }

  Widget _buildDateTimeField(DateTime dateTime, BuildContext context) {
    return CustomFormField<DateTime>(
      initialValue: dateTime,
      validator: FormValidators.nonNull('Please select date and time.'),
      builder: (field) => DateTimePicker(
        initialDateTime: dateTime,
        onSelect: (selectedDateTime) {
          field.didChange(selectedDateTime);
          context.bloc<CheckpointFormCubit>().changeDateTime(selectedDateTime);
        },
      ),
    );
  }

  Widget _buildDescriptionField(String description, BuildContext context) {
    return CustomTextField(
      label: 'Description',
      validator: (_) => null,
      icon: Icons.description,
      initialValue: description,
      onChanged: (desc) => context.bloc<CheckpointFormCubit>().changeDescription(desc),
    );
  }

  Widget _buildSubmitButton(CheckpointFormState state, BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: AppColors.dark,
      child: const Icon(
        Icons.check,
        size: 24.0,
        color: AppColors.primary,
      ),
      onPressed: () {
        if (!_formKey.currentState.validate()) return;

        onSubmit(state.checkpoint);
        Navigator.of(context).pop();
      },
    );
  }
}
