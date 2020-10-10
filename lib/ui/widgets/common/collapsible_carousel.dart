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
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: CloseIcon(
            backgroundColor: AppColors.light,
            iconColor: AppColors.dark,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: _buildCarousel(),
        collapseMode: CollapseMode.pin,
        titlePadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        title: Text(
          title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.medium.serif,
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Hero(
      tag: heroId,
      child: GradientContainer(
        gradientColors: [
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          AppColors.light.withOpacity(0.2),
          AppColors.light.withOpacity(0.5),
          AppColors.light.withOpacity(0.8),
          AppColors.light,
        ],
        child: Carousel(
          imageUrls: imageUrls,
          showPagination: false,
          height: double.infinity,
        ),
      ),
    );
  }
}
