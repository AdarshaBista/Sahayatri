import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:sahayatri/core/utils/form_validators.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/checkpoint_form_cubit/checkpoint_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/mini_fab.dart';
import 'package:sahayatri/ui/widgets/common/sheet_header.dart';
import 'package:sahayatri/ui/widgets/dialogs/unsaved_dialog.dart';
import 'package:sahayatri/ui/widgets/forms/custom_text_field.dart';
import 'package:sahayatri/ui/widgets/forms/custom_form_field.dart';
import 'package:sahayatri/ui/widgets/common/circular_checkbox.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/place_picker.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/date_time_picker.dart';

class CheckpointForm extends StatelessWidget {
  final Checkpoint? checkpoint;
  final void Function(Checkpoint) onSubmit;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CheckpointForm({
    required this.onSubmit,
    this.checkpoint,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckpointFormCubit>(
      create: (_) => CheckpointFormCubit(checkpoint: checkpoint),
      child: BlocBuilder<CheckpointFormCubit, CheckpointFormState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => _handleBackButton(context),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                children: [
                  SheetHeader(
                    onClose: () async {
                      if (await _handleBackButton(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    title: checkpoint == null
                        ? 'Add a checkpoint'
                        : 'Edit checkpoint',
                  ),
                  _buildPlaceField(state.place, context),
                  const SizedBox(height: 16.0),
                  _buildDateTimeField(state.dateTime, context),
                  const SizedBox(height: 16.0),
                  _buildDescriptionField(state.description, context),
                  const SizedBox(height: 12.0),
                  _buildNotifyContactToggle(state.notifyContact, context),
                  const SizedBox(height: 16.0),
                  _buildSubmitButton(state, context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceField(Place? place, BuildContext context) {
    return CustomFormField<Place>(
      initialValue: place,
      validator: FormValidators.nonNull('Please select a place.'),
      builder: (field) => PlacePicker(
        initialPlace: place,
        onSelect: (selectedPlace) {
          field.didChange(selectedPlace);
          context.read<CheckpointFormCubit>().changePlace(selectedPlace);
        },
      ),
    );
  }

  Widget _buildDateTimeField(DateTime? dateTime, BuildContext context) {
    return CustomFormField<DateTime>(
      initialValue: dateTime,
      validator: FormValidators.nonNull('Please select date and time.'),
      builder: (field) => DateTimePicker(
        initialDateTime: dateTime,
        onSelect: (selectedDateTime) {
          field.didChange(selectedDateTime);
          context.read<CheckpointFormCubit>().changeDateTime(selectedDateTime);
        },
      ),
    );
  }

  Widget _buildDescriptionField(String description, BuildContext context) {
    return CustomTextField(
      label: 'Description',
      hintText: 'No description provided',
      validator: (_) => null,
      initialValue: description,
      icon: AppIcons.description,
      onChanged: (desc) =>
          context.read<CheckpointFormCubit>().changeDescription(desc),
    );
  }

  Widget _buildNotifyContactToggle(bool shouldSendSms, BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      trailing: CircularCheckbox(
        value: shouldSendSms,
        onSelect: (value) =>
            context.read<CheckpointFormCubit>().toggleNotifyContact(value),
      ),
      title: Text(
        'Notify Contact',
        style: context.t.headline5?.bold,
      ),
      subtitle: Text(
        'Notify close contact via SMS when you reach this checkpoint.',
        style: context.t.headline6,
      ),
    );
  }

  Widget _buildSubmitButton(CheckpointFormState state, BuildContext context) {
    return MiniFab(
      onTap: () {
        if (!(_formKey.currentState?.validate() ?? false)) return;

        onSubmit(state.checkpoint);
        Navigator.of(context).pop();
      },
    );
  }

  Future<bool> _handleBackButton(BuildContext context) async {
    if (context.read<CheckpointFormCubit>().isDirty) {
      const UnsavedDialog().openDialog(context);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
