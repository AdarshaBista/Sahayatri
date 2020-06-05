import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/itinerary_timeline.dart';

class ItineraryDetails {
  final BuildContext context;
  final Itinerary itinerary;

  const ItineraryDetails({
    @required this.context,
    @required this.itinerary,
  })  : assert(context != null),
        assert(itinerary != null);

  Widget _build() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 20.0),
          Expanded(
            child: ItineraryTimeline(checkpoints: itinerary.checkpoints),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      title: Text(
        itinerary.name,
        style: AppTextStyles.large.bold,
      ),
      subtitle: Text(
        '${itinerary.days} days ${itinerary.nights} nights',
        style: AppTextStyles.small.bold,
      ),
      trailing: IconButton(
        icon: Icon(
          CommunityMaterialIcons.map_search_outline,
          size: 24.0,
          color: AppColors.primary,
        ),
        onPressed: () => context.repository<DestinationNavService>().pushNamed(
              Routes.kRoutePageRoute,
              arguments: itinerary.checkpoints.map((c) => c.place).toList(),
            ),
      ),
    );
  }

  void show() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: false,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      barrierColor: AppColors.dark.withOpacity(0.4),
      builder: (_) => _build(),
    );
  }
}
