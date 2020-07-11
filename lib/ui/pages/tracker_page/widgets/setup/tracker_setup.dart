import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/setup/setup_tile.dart';

class TrackerSetup extends StatelessWidget {
  const TrackerSetup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Setup'),
      floatingActionButton: _buildStartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 64.0,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildItineraryTile(),
          _buildContactTile(),
          _buildPeerNetworkTile(),
        ],
      ),
    );
  }

  Widget _buildItineraryTile() {
    return SetupTile(
      icon: CommunityMaterialIcons.map_search_outline,
      isFirst: true,
      title: 'Choose an itinerary',
      child: Container(
        height: 200,
        color: Colors.red,
      ),
    );
  }

  Widget _buildContactTile() {
    return SetupTile(
      icon: CommunityMaterialIcons.account_alert_outline,
      title: 'Choose a contact',
      child: Container(
        height: 200,
        color: Colors.green,
      ),
    );
  }

  Widget _buildPeerNetworkTile() {
    return SetupTile(
      icon: CommunityMaterialIcons.access_point_network,
      isLast: true,
      title: 'Setup a peer network',
      child: Container(
        height: 200,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        'Start',
        style: AppTextStyles.small.primary,
      ),
      onPressed: () => context.bloc<TrackerBloc>().add(TrackingStarted(
            destination: context.bloc<DestinationBloc>().destination,
          )),
    );
  }
}
