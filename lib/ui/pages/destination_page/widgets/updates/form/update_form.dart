import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/api_service.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';
import 'package:sahayatri/cubits/destination_update_cubit/destination_update_cubit.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/dialogs/unsaved_dialog.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/tags_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/update_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/images_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/location_field.dart';

class UpdateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DestinationUpdateFormCubit>(
      create: (context) => DestinationUpdateFormCubit(
        apiService: context.read<ApiService>(),
        destination: context.read<DestinationCubit>().destination,
        destinationUpdateCubit: context.read<DestinationUpdateCubit>(),
      ),
      child: AnimatedPadding(
        curve: Curves.decelerate,
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 200),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            children: [
              _buildHeader(context),
              const Divider(height: 16.0),
              const TagsField(),
              const SizedBox(height: 16.0),
              const ImagesField(),
              const SizedBox(height: 12.0),
              const LocationField(),
              const SizedBox(height: 12.0),
              const UpdateField(),
              const SizedBox(height: 4.0),
              _buildMessage(),
              const SizedBox(height: 4.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Post an update', style: context.t.headline4.bold),
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => _handleBackButton(context),
              child: const Icon(
                Icons.close,
                color: AppColors.secondary,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMessage() {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        if (state.message == null) return const Offstage();
        return Text(
          state.message,
          style: AppTextStyles.headline6.secondary,
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        return FloatingActionButton(
          mini: true,
          child: state.isLoading
              ? const CircularBusyIndicator()
              : const Icon(
                  Icons.check,
                  size: 24.0,
                  color: AppColors.primary,
                ),
          onPressed: () async {
            if (state.isLoading) return;
            if (!formKey.currentState.validate()) return;

            final success = await context.read<DestinationUpdateFormCubit>().postUpdate();
            if (success) Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _handleBackButton(BuildContext context) {
    if (context.read<DestinationUpdateFormCubit>().isDirty) {
      const UnsavedDialog().openDialog(context);
      return;
    }
    Navigator.of(context).pop();
  }
}
