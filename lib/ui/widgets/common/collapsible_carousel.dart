import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/carousel.dart';
import 'package:sahayatri/ui/widgets/buttons/close_icon.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';

class CollapsibleCarousel extends StatelessWidget {
  final String title;
  final String heroId;
  final List<String> imageUrls;

  const CollapsibleCarousel({
    @required this.title,
    @required this.heroId,
    @required this.imageUrls,
  })  : assert(title != null),
        assert(heroId != null),
        assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 8.0,
      expandedHeight: 280.0,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: CloseIcon(
            iconColor: context.c.onBackground,
            backgroundColor: context.c.background,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: _buildCarousel(context),
        collapseMode: CollapseMode.pin,
        titlePadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        title: Text(
          title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: context.t.headline4.serif,
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return Hero(
      tag: heroId,
      child: GradientContainer(
        gradientBegin: Alignment.topCenter,
        gradientEnd: Alignment.bottomCenter,
        gradientColors: AppColors.getCollapsibleHeaderGradient(context.c.background),
        child: Carousel(
          imageUrls: imageUrls,
          showPagination: false,
          height: double.infinity,
        ),
      ),
    );
  }
}
