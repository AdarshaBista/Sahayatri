import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';
import 'package:sahayatri/cubits/lodge_review_cubit/lodge_review_cubit.dart';

import 'package:sahayatri/ui/widgets/review/review_list.dart';
import 'package:sahayatri/ui/widgets/common/photo_gallery.dart';
import 'package:sahayatri/ui/widgets/common/nested_tab_view.dart';
import 'package:sahayatri/ui/widgets/common/collapsible_carousel.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/header_tile.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/contacts_list.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/facalities_list.dart';

class LodgePage extends StatelessWidget {
  const LodgePage();

  @override
  Widget build(BuildContext context) {
    final lodge = context.watch<Lodge>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            CollapsibleCarousel(
              title: lodge.name,
              heroId: lodge.id,
              imageUrls: lodge.imageUrls,
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            const HeaderTile(),
            const SizedBox(height: 10.0),
            const FacilitiesList(),
            const SizedBox(height: 16.0),
            const ContactList(),
            const SizedBox(height: 16.0),
            _buildTabView(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context) {
    final lodge = context.watch<Lodge>();

    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: Icons.photo_outlined),
        NestedTabData(label: 'Reviews', icon: Icons.star_outline),
      ],
      children: [
        PhotoGallery(imageUrls: lodge.imageUrls),
        ReviewList(reviewCubit: context.bloc<ReviewCubit>() as LodgeReviewCubit),
      ],
    );
  }
}
