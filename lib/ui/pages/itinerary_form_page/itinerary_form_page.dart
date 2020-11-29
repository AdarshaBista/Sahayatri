import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/extensions/dialog_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/dialogs/unsaved_dialog.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/itinerary_form.dart';

class ItineraryFormPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ItineraryFormPage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBackButton(context),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFab(context),
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: const ItineraryForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return BlocBuilder<ItineraryFormCubit, ItineraryFormState>(
      builder: (context, state) {
        return FloatingActionButton(
          mini: true,
          child: const Icon(
            Icons.check,
            size: 24.0,
            color: AppColors.primary,
          ),
          onPressed: () => _saveItinerary(context, state.itinerary),
        );
      },
    );
  }

  void _saveItinerary(BuildContext context, Itinerary itinerary) {
    if (!_formKey.currentState.validate()) return;

    context.read<UserItineraryCubit>().createItinerary(itinerary);
    Navigator.of(context).pop();
  }

  Future<bool> _handleBackButton(BuildContext context) {
    if (context.read<ItineraryFormCubit>().isDirty) {
      const UnsavedDialog().openDialog(context);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
