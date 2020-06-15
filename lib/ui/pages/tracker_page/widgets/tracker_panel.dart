import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/pill.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_stats.dart';
import 'package:sahayatri/ui/styles/app_text_styles.dart';

class TrackerPanel extends StatelessWidget {
  final TrackerSuccess state;
  final double collapsedHeight;
  final ScrollController controller;

  const TrackerPanel({
    @required this.state,
    @required this.controller,
    @required this.collapsedHeight,
  })  : assert(state != null),
        assert(controller != null),
        assert(collapsedHeight != null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 4.0),
          const Pill(),
          StreamBuilder<UserLocation>(
            stream: state.userLocationStream,
            initialData: state.initialLocation,
            builder: (context, snapshot) {
              return TrackerStats(
                height: collapsedHeight,
                userLocation: snapshot.data,
              );
            },
          ),
          StreamBuilder<bool>(
            stream: state.userAlertStream,
            initialData: false,
            builder: (context, snapshot) {
              return Text(
                snapshot.data.toString(),
                style: AppTextStyles.medium,
              );
            },
          ),
        ],
      ),
    );
  }
}
