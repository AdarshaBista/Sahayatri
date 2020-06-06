import 'package:flutter/material.dart';

import 'package:sahayatri/app/extensions/widget_x.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/checkpoint_form_bloc/checkpoint_form_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/required_dialog.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/custom_text_field.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/place_picker.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/date_time_picker.dart';

class CheckpointForm extends StatelessWidget {
  final Checkpoint checkpoint;
  final Function(Checkpoint) onSubmit;

  CheckpointForm({
    @required this.onSubmit,
    @required this.checkpoint,
  }) : assert(onSubmit != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckpointFormBloc>(
      create: (_) => CheckpointFormBloc(checkpoint: checkpoint),
      child: AnimatedPadding(
        curve: Curves.decelerate,
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 200),
        child: BlocBuilder<CheckpointFormBloc, CheckpointFormState>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              children: [
                Text(
                  'Create a Checkpoint',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium.bold,
                ),
                const Divider(height: 24.0),
                _buildDescriptionField(state.description, context),
                const SizedBox(height: 16.0),
                _buildPlaceField(state.place, context),
                const SizedBox(height: 16.0),
                _buildDateTimeField(state.dateTime, context),
                const SizedBox(height: 16.0),
                _buildSubmitButton(state, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionField(String description, BuildContext context) {
    return CustomTextField(
      label: 'Description',
      icon: Icons.description,
      initialValue: description,
      onChanged: (desc) => context.bloc<CheckpointFormBloc>().add(
            DescriptionChanged(description: desc),
          ),
    );
  }

  Widget _buildPlaceField(Place place, BuildContext context) {
    return PlacePicker(
      initialPlace: place,
      onSelect: (selectedPlace) => context.bloc<CheckpointFormBloc>().add(
            PlaceChanged(place: selectedPlace),
          ),
    );
  }

  Widget _buildDateTimeField(DateTime dateTime, BuildContext context) {
    return DateTimePicker(
      initialDateTime: dateTime,
      onSelect: (selectedDateTime) => context.bloc<CheckpointFormBloc>().add(
            DateTimeChanged(dateTime: selectedDateTime),
          ),
    );
  }

  Widget _buildSubmitButton(CheckpointFormState state, BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: AppColors.dark,
      child: Icon(
        Icons.check,
        color: AppColors.primary,
        size: 24.0,
      ),
      onPressed: () {
        if (!state.isValid) {
          RequiredDialog().openDialog(context);
          return;
        }
        onSubmit(state.checkpoint);
        context.repository<DestinationNavService>().pop();
      },
    );
  }
}
