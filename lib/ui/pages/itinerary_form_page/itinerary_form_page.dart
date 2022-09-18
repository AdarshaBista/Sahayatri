import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/models/itinerary.dart';

import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/itinerary_form/itinerary_form.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_appbar.dart';
import 'package:sahayatri/ui/widgets/buttons/mini_fab.dart';
import 'package:sahayatri/ui/widgets/dialogs/unsaved_dialog.dart';
import 'package:sahayatri/ui/widgets/views/collapsible_view.dart';

class ItineraryFormPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ItineraryFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBackButton(context),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFab(context),
        body: CollapsibleView(
          collapsible: CollapsibleAppbar(
            title: 'Create an itinerary',
            onBack: () async {
              if (await _handleBackButton(context)) {
                Navigator.of(context).pop();
              }
            },
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: const ItineraryForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return BlocBuilder<ItineraryFormCubit, ItineraryFormState>(
      builder: (context, state) {
        return MiniFab(
          onTap: () {
            _saveItinerary(context, state.itinerary);
            context.read<TrackerCubit>().changeItinerary(state.itinerary);
          },
        );
      },
    );
  }

  void _saveItinerary(BuildContext context, Itinerary itinerary) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

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
