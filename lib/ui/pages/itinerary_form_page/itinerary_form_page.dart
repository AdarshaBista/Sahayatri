import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/itinerary_form.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/required_dialog.dart';

class ItineraryFormPage extends StatelessWidget {
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
    return BlocBuilder<ItineraryFormBloc, ItineraryFormState>(
      builder: (context, state) {
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
            if (!state.isValid) {
              RequiredDialog(context: context).show();
              return;
            }

            context
                .bloc<DestinationBloc>()
                .add(ItineraryCreated(itinerary: state.itinerary));
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
