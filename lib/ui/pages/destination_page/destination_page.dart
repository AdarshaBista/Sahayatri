import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';
import 'package:sahayatri/cubits/destination_review_cubit/destination_review_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/review/review_list.dart';
import 'package:sahayatri/ui/widgets/common/photo_gallery.dart';
import 'package:sahayatri/ui/widgets/common/nested_tab_view.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_carousel.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/extra_card.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/open_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/header_tile.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/route_actions.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/destination_stats.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/update_list.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage();

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<Destination>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            CollapsibleCarousel(
              title: destination.name,
              imageUrls: destination.imageUrls,
              onBack: () => context.read<RootNavService>().pop(),
            ),
          ];
        },
        body: _buildList(context, destination),
      ),
    );
  }

  Widget _buildList(BuildContext context, Destination destination) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        const HeaderTile(),
        const SizedBox(height: 8.0),
        _buildDescription(context, destination),
        const SizedBox(height: 12.0),
        const OpenButton(),
        const SizedBox(height: 12.0),
        const RouteActions(),
        const SizedBox(height: 8.0),
        const DestinationStats(),
        const SizedBox(height: 8.0),
        const ExtraCard(),
        const SizedBox(height: 4.0),
        _buildTabView(context, destination),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, Destination destination) {
    return FadeAnimator(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          destination.description,
          textAlign: TextAlign.left,
          style: context.t.headline5.serif,
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context, Destination destination) {
    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: Icons.photo_outlined),
        NestedTabData(label: 'Reviews', icon: Icons.star_outline),
        NestedTabData(label: 'Updates', icon: Icons.featured_play_list_outlined),
      ],
      children: [
        PhotoGallery(imageUrls: destination.imageUrls),
        ReviewList(reviewCubit: context.watch<ReviewCubit>() as DestinationReviewCubit),
        const UpdateList(),
      ],
    );
  }
}
