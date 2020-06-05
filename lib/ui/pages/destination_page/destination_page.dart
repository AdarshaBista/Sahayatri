import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/shared/widgets/carousel.dart';
import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:sahayatri/ui/shared/widgets/photo_gallery.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/rating_row.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/permit_card.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/review_list.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/destination_info.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/best_months_chips.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/destination_stats.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return Scaffold(
      appBar: CustomAppbar(
        title: destination.name,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => context.repository<RootNavService>().pop(),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Hero(
            tag: destination.id,
            child: Carousel(imageUrls: destination.imageUrls),
          ),
          const SizedBox(height: 16.0),
          const RatingRow(),
          const Divider(height: 16.0),
          const DestinationInfo(),
          const Divider(height: 16.0),
          const DestinationStats(),
          const Divider(height: 16.0),
          const PermitCard(),
          const SizedBox(height: 16.0),
          const BestMonthsChips(),
          const Divider(height: 16.0),
          NestedTabView(
            tabs: [
              NestedTabData(label: 'Photos', icon: Icons.photo),
              NestedTabData(label: 'Reviews', icon: Icons.rate_review),
            ],
            children: [
              PhotoGallery(imageUrls: destination.imageUrls),
              ReviewList(reviews: destination.reviews),
            ],
          ),
        ],
      ),
    );
  }
}
