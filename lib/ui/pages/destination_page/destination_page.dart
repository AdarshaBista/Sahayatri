import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
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
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/open_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/header_tile.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/permit_card.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/route_actions.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/destination_stats.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/best_months_chips.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/update_list.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return Scaffold(
      appBar: CurvedAppbar(
        title: destination.name,
        actions: [
          IconButton(
            splashRadius: 20.0,
            icon: const Icon(Icons.close),
            onPressed: () => context.repository<RootNavService>().pop(),
          ),
        ],
      ),
      body: context.bloc<UserCubit>().isAuthenticated
          ? FutureBuilder(
              future: context.bloc<DestinationCubit>().open(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) return _buildList(context);
                return const BusyIndicator();
              },
            )
          : _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        Carousel(imageUrls: destination.imageUrls),
        const SizedBox(height: 16.0),
        const HeaderTile(),
        const SizedBox(height: 8.0),
        const OpenButton(),
        const SizedBox(height: 8.0),
        _buildDescription(destination),
        const SizedBox(height: 8.0),
        const RouteActions(),
        const SizedBox(height: 8.0),
        const DestinationStats(),
        const Divider(height: 16.0, indent: 20.0, endIndent: 20.0),
        const PermitCard(),
        const SizedBox(height: 16.0),
        const BestMonthsChips(),
        const SizedBox(height: 8.0),
        const Divider(height: 8.0, indent: 20.0, endIndent: 20.0),
        _buildTabView(context, destination),
      ],
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
        NestedTabData(label: 'Photos', icon: Icons.photo_outlined),
        NestedTabData(label: 'Reviews', icon: Icons.star_outline),
        NestedTabData(label: 'Updates', icon: Icons.featured_play_list_outlined),
      ],
      children: [
        PhotoGallery(imageUrls: destination.imageUrls),
        ReviewList(reviewCubit: context.bloc<ReviewCubit>() as DestinationReviewCubit),
        const UpdateList(),
      ],
    );
  }
}
