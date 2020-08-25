import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';
import 'package:sahayatri/cubits/lodge_review_cubit/lodge_review_cubit.dart';

import 'package:sahayatri/ui/shared/review/review_list.dart';
import 'package:sahayatri/ui/shared/widgets/carousel.dart';
import 'package:sahayatri/ui/shared/widgets/curved_appbar.dart';
import 'package:sahayatri/ui/shared/widgets/photo_gallery.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/lodge_rating.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/contact_chips.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/facalities_list.dart';

class LodgePage extends StatelessWidget {
  const LodgePage();

  @override
  Widget build(BuildContext context) {
    final lodge = context.watch<Lodge>();

    return Scaffold(
      appBar: CurvedAppbar(title: lodge.name),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildCarousel(lodge),
          const SizedBox(height: 8.0),
          const LodgeRating(),
          const Divider(height: 16.0),
          const FacilitiesList(),
          const SizedBox(height: 16.0),
          const ContactChips(),
          const SizedBox(height: 8.0),
          const Divider(height: 12.0),
          _buildTabView(context, lodge),
        ],
      ),
    );
  }

  Widget _buildCarousel(Lodge lodge) {
    return Hero(
      tag: lodge.id,
      child: Carousel(imageUrls: lodge.imageUrls),
    );
  }

  Widget _buildTabView(BuildContext context, Lodge lodge) {
    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: Icons.photo),
        NestedTabData(label: 'Reviews', icon: Icons.rate_review),
      ],
      children: [
        PhotoGallery(imageUrls: lodge.imageUrls),
        ReviewList(reviewCubit: context.bloc<ReviewCubit>() as LodgeReviewCubit),
      ],
    );
  }
}
