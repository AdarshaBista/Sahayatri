import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_cubit/destination_update_cubit.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/sheet_header.dart';
import 'package:sahayatri/ui/widgets/dialogs/unsaved_dialog.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/tags_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/update_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/images_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/form/location_field.dart';

class UpdateForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DestinationUpdateFormCubit>(
      create: (context) => DestinationUpdateFormCubit(
        destination: context.read<Destination>(),
        destinationUpdateCubit: context.read<DestinationUpdateCubit>(),
      ),
      child: Builder(
        builder: (context) => WillPopScope(
          onWillPop: () => _handleBackButton(context),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              children: [
                _buildHeader(context),
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SheetHeader(
      title: 'Post an update',
      onClose: () async {
        if (await _handleBackButton(context)) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Widget _buildMessage() {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        if (state.message == null) return const SizedBox();

        return Text(
          state.message!,
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
                  AppIcons.confirm,
                  size: 24.0,
                ),
          onPressed: () async {
            if (state.isLoading) return;
            if (!(_formKey.currentState?.validate() ?? false)) return;

            final success =
                await context.read<DestinationUpdateFormCubit>().postUpdate();
            if (success) Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<bool> _handleBackButton(BuildContext context) async {
    if (context.read<DestinationUpdateFormCubit>().isDirty) {
      const UnsavedDialog().openDialog(context);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
