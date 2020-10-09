import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/contact_form.dart';
import 'package:sahayatri/ui/shared/nearby/nearby_form.dart';

class TrackerSetup extends StatelessWidget {
  const TrackerSetup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Review your settings', style: AppTextStyles.medium.serif),
      ),
      floatingActionButton: _buildStartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 64.0),
        children: [
          _buildChild(const NearbyForm(isOnSettings: false)),
          _buildChild(const ContactForm(isOnSettings: false)),
        ],
      ),
    );
  }

  Widget _buildChild(Widget child) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: child,
        ),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        'START',
        style: AppTextStyles.small.primary.bold,
      ),
      onPressed: () => context
          .bloc<TrackerCubit>()
          .startTracking(context.bloc<DestinationCubit>().destination),
    );
  }
}
