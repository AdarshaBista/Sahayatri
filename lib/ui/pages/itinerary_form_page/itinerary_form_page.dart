import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/itinerary_form.dart';

class ItineraryFormPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ItineraryFormPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFab(context),
      appBar: CustomAppbar(
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
    return BlocBuilder<ItineraryFormBloc, ItineraryFormState>(
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

    context.bloc<DestinationBloc>().add(ItineraryCreated(itinerary: state.itinerary));
    context.repository<DestinationNavService>().pop();
  }
}
