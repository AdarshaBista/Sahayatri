import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/curved_appbar.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/itinerary_form.dart';

class ItineraryFormPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ItineraryFormPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFab(context),
      appBar: const CurvedAppbar(
        elevation: 0.0,
        title: 'Create an Itinerary',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: const ItineraryForm(),
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return BlocBuilder<ItineraryFormCubit, ItineraryFormState>(
      builder: (context, state) {
        return FloatingActionButton.extended(
          backgroundColor: AppColors.dark,
          icon: const Icon(
            Icons.save,
            size: 20.0,
            color: AppColors.primary,
          ),
          label: Text(
            'Save Itinerary',
            style: AppTextStyles.small.primary,
          ),
          onPressed: () => _saveItinerary(context, state),
        );
      },
    );
  }

  void _saveItinerary(BuildContext context, ItineraryFormState state) {
    if (!_formKey.currentState.validate()) return;

    context.bloc<DestinationCubit>().createItinerary(state.itinerary);
    Navigator.of(context).pop();
  }
}
