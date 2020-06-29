import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/loading_indicator.dart';
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
          return TrackerPanel(state: state);
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
}
