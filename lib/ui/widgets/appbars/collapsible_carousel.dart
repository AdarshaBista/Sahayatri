import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/carousel.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_appbar.dart';

class CollapsibleCarousel extends StatelessWidget {
  final String title;
  final String heroId;
  final VoidCallback onBack;
  final List<String> imageUrls;

  const CollapsibleCarousel({
    this.heroId,
    this.onBack,
    @required this.title,
    @required this.imageUrls,
  })  : assert(title != null),
        assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return CollapsibleAppbar(
      title: title,
      offset: 180.0,
      height: 240.0,
      onBack: onBack,
      background: _buildCarousel(context),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    final carousel = GradientContainer(
      gradientBegin: Alignment.topCenter,
      gradientEnd: Alignment.bottomCenter,
      gradientColors: AppColors.getCollapsibleHeaderGradient(context.c.background),
      child: Carousel(
        imageUrls: imageUrls,
        showPagination: false,
        height: double.infinity,
      ),
    );

    return heroId == null ? carousel : Hero(tag: heroId, child: carousel);
  }
}
