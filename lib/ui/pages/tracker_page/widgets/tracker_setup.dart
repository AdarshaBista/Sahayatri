import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/settings/settings_list.dart';
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
          return [const CollapsibleAppbar(title: 'Review your settings')];
        },
        body: const SettingsList(),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        'START',
        style: AppTextStyles.headline5.primary.bold,
      ),
      onPressed: () =>
          context.read<TrackerCubit>().startTracking(context.read<Destination>()),
    );
  }
}
