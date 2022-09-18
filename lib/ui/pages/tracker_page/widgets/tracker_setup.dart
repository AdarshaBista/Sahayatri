import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_appbar.dart';
import 'package:sahayatri/ui/widgets/tools/tools_list.dart';
import 'package:sahayatri/ui/widgets/views/collapsible_view.dart';

class TrackerSetup extends StatelessWidget {
  const TrackerSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildStartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: const CollapsibleView(
        collapsible: CollapsibleAppbar(title: 'Setup your tools'),
        child: ToolsList(),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        'START',
        style: AppTextStyles.headline5.bold.withColor(context.c.background),
      ),
      onPressed: () {
        final destination = context.read<Destination>();
        final itinerary = context.read<UserItineraryCubit>().userItinerary;
        context.read<TrackerCubit>().startTracking(destination, itinerary);
      },
    );
  }
}
