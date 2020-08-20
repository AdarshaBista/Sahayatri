import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';
import 'package:sahayatri/cubits/destination_review_cubit/destination_review_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/review/review_list.dart';
import 'package:sahayatri/ui/shared/widgets/carousel.dart';
import 'package:sahayatri/ui/shared/widgets/curved_appbar.dart';
import 'package:sahayatri/ui/shared/widgets/photo_gallery.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/open_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/rating_tile.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/permit_card.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/route_actions.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/destination_stats.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/best_months_chips.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return Scaffold(
      appBar: CurvedAppbar(
        title: destination.name,
        leading: IconButton(
          splashRadius: 20.0,
          icon: const Icon(Icons.close),
          onPressed: () => context.repository<RootNavService>().pop(),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildCarousel(destination),
          const SizedBox(height: 16.0),
          const RatingTile(),
          const SizedBox(height: 8.0),
          const OpenButton(),
          const SizedBox(height: 8.0),
          _buildDescription(destination),
          const SizedBox(height: 8.0),
          const RouteActions(),
          const Divider(height: 16.0),
          const DestinationStats(),
          const Divider(height: 16.0),
          const PermitCard(),
          const SizedBox(height: 16.0),
          const BestMonthsChips(),
          const SizedBox(height: 8.0),
          _buildTabView(context, destination),
        ],
      ),
    );
  }

  Hero _buildCarousel(Destination destination) {
    return Hero(
      tag: destination.id.toString(),
      child: Carousel(imageUrls: destination.imageUrls),
    );
  }

  Widget _buildDescription(Destination destination) {
    return FadeAnimator(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          destination.description,
          textAlign: TextAlign.left,
          style: AppTextStyles.small.serif,
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context, Destination destination) {
    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: Icons.photo),
        NestedTabData(label: 'Reviews', icon: Icons.rate_review),
      ],
      children: [
        PhotoGallery(imageUrls: destination.imageUrls),
        ReviewList(reviewCubit: context.bloc<ReviewCubit>() as DestinationReviewCubit),
      ],
    );
  }
}
