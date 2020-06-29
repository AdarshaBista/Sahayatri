import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/sliding_panel.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/loading_indicator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_map.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_panel.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/incorrect_location_info.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerBloc, TrackerState>(
      builder: (context, state) {
        if (state is TrackerLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const LoadingIndicator(),
          );
        } else if (state is TrackerSuccess) {
          return _buildTracker(state);
        } else if (state is TrackerError) {
          return Scaffold(
            appBar: AppBar(),
            body: ErrorIndicator(message: state.message),
          );
        } else {
          return const IncorrectLocationInfo();
        }
      },
    );
  }

  Widget _buildTracker(TrackerSuccess state) {
    const double kCollapsedHeight = 100.0;
    return Scaffold(
      body: SlidingPanel(
        minHeight: kCollapsedHeight,
        body: TrackerMap(userLocation: state.userLocation),
        panelBuilder: (sc) => TrackerPanel(
          state: state,
          controller: sc,
          collapsedHeight: kCollapsedHeight,
        ),
      ),
    );
  }
}
