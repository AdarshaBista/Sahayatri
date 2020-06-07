import 'package:flutter/material.dart';

import 'package:sahayatri/app/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/required_dialog.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/itinerary_form.dart';

class ItineraryFormPage extends StatelessWidget {
  const ItineraryFormPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFab(context),
      appBar: CustomAppbar(
        title: 'Create a Itinerary',
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ItineraryForm(),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    final formState = context.bloc<ItineraryFormBloc>().state;

    return FloatingActionButton.extended(
      backgroundColor: AppColors.dark,
      icon: Icon(
        Icons.save,
        size: 20.0,
        color: AppColors.primary,
      ),
      label: Text(
        'Save Itinerary',
        style: AppTextStyles.small.primary,
      ),
      onPressed: () {
        if (!formState.isValid) {
          RequiredDialog().openDialog(context);
          return;
        }

        if (formState.isTemplate) {
          RequiredDialog(
            message: 'Please select appropriate date for checkpoints.',
          ).openDialog(context);
          return;
        }

        context
            .bloc<DestinationBloc>()
            .add(ItineraryCreated(itinerary: formState.itinerary));
        context.repository<DestinationNavService>().pop();
      },
    );
  }
}
