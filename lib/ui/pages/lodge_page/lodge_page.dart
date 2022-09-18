import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/cubits/lodge_review_cubit/lodge_review_cubit.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:sahayatri/ui/pages/lodge_page/widgets/contacts_list.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/facalities_list.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/header_tile.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_carousel.dart';
import 'package:sahayatri/ui/widgets/image/photo_gallery.dart';
import 'package:sahayatri/ui/widgets/review/review_list.dart';
import 'package:sahayatri/ui/widgets/views/collapsible_view.dart';
import 'package:sahayatri/ui/widgets/views/nested_tab_view.dart';

class LodgePage extends StatelessWidget {
  const LodgePage({super.key});

  @override
  Widget build(BuildContext context) {
    final lodge = context.watch<Lodge>();

    return Scaffold(
      body: CollapsibleView(
        collapsible: CollapsibleCarousel(
          title: lodge.name,
          heroId: lodge.id,
          imageUrls: lodge.imageUrls,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            const HeaderTile(),
            const SizedBox(height: 16.0),
            const FacilitiesList(),
            const SizedBox(height: 16.0),
            const ContactList(),
            const SizedBox(height: 8.0),
            _buildTabView(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context) {
    return NestedTabView(
      tabs: [
        NestedTabData(label: 'Photos', icon: AppIcons.photos),
        NestedTabData(label: 'Reviews', icon: AppIcons.reviews),
      ],
      children: [
        PhotoGallery(imageUrls: context.watch<Lodge>().imageUrls),
        ReviewList(
          reviewCubit:
              BlocProvider.of<ReviewCubit>(context) as LodgeReviewCubit,
        ),
      ],
    );
  }
}
