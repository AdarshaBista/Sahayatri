import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/user_location.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sahayatri/ui/shared/widgets/pill.dart';
import 'package:sahayatri/ui/shared/widgets/close_icon.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/loading_indicator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_map.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/incorrect_location_info.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage();

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  static const kCollapsedHeight = 100.0;
  double panelOpenPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TrackerBloc, TrackerState>(
        builder: (context, state) {
          if (state is TrackerLocationError) {
            return const IncorrectLocationInfo();
          } else if (state is TrackerSuccess) {
            return _buildBody(state);
          } else if (state is TrackerError) {
            return Scaffold(
              appBar: AppBar(),
              body: ErrorIndicator(message: state.message),
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: const LoadingIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(TrackerSuccess state) {
    return SlidingUpPanel(
      color: AppColors.background,
      parallaxOffset: 0.1,
      backdropOpacity: 0.6,
      isDraggable: true,
      parallaxEnabled: true,
      backdropEnabled: true,
      renderPanelSheet: true,
      backdropTapClosesPanel: true,
      slideDirection: SlideDirection.UP,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      minHeight: kCollapsedHeight,
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      onPanelSlide: (value) => setState(() {
        panelOpenPercent = value;
      }),
      body: _buildMap(state),
      panelBuilder: (sc) => _buildPanel(sc, state),
    );
  }

  Stack _buildMap(TrackerSuccess state) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        StreamBuilder<UserLocation>(
          stream: state.userLocationStream,
          initialData: state.initialLocation,
          builder: (context, snapshot) {
            return TrackerMap(userLocation: snapshot.data);
          },
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: Transform.rotate(
            angle: panelOpenPercent * 2 * 3.1415,
            child: Transform.scale(
              scale: 1.0 - panelOpenPercent,
              child: SafeArea(child: const CloseIcon()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPanel(ScrollController controller, TrackerSuccess state) {
    return SingleChildScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 4.0),
          const Pill(),
          StreamBuilder<UserLocation>(
            stream: state.userLocationStream,
            initialData: state.initialLocation,
            builder: (context, snapshot) {
              return TrackerStats(
                height: kCollapsedHeight,
                userLocation: snapshot.data,
              );
            },
          ),
        ],
      ),
    );
  }
}
