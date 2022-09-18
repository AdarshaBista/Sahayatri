import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:sahayatri/core/constants/images.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/incorrect_location_info.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_panel.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_setup.dart';
import 'package:sahayatri/ui/widgets/appbars/empty_appbar.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerCubit, TrackerState>(
      builder: (context, state) {
        if (state is TrackerLoading) {
          return const Scaffold(
            appBar: EmptyAppbar(),
            body: BusyIndicator(
              padding: 32.0,
              imageUrl: Images.trackerLoading,
            ),
          );
        } else if (state is TrackerSettingUp) {
          return const TrackerSetup();
        } else if (state is TrackerUpdating) {
          return Provider<TrackerUpdate>.value(
            value: state.update,
            child: const TrackerPanel(),
          );
        } else if (state is TrackerError) {
          return Scaffold(
            appBar: AppBar(),
            body: ErrorIndicator(
              message: state.message,
              imageUrl: Images.trackerError,
            ),
          );
        } else {
          return const IncorrectLocationInfo();
        }
      },
    );
  }
}
