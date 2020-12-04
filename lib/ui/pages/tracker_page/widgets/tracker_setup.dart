import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/tools/tools_list.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_appbar.dart';

class TrackerSetup extends StatelessWidget {
  const TrackerSetup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildStartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [const CollapsibleAppbar(title: 'Review your tools')];
        },
        body: const ToolsList(),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        'START',
        style: AppTextStyles.headline5.bold.withColor(context.c.background),
      ),
      onPressed: () =>
          context.read<TrackerCubit>().startTracking(context.read<Destination>()),
    );
  }
}
