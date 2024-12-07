import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/appbars/collapsible_appbar.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';
import 'package:sahayatri/ui/widgets/image/carousel.dart';

class CollapsibleCarousel extends StatelessWidget {
  final String title;
  final List<String> imageUrls;
  final String? heroId;
  final VoidCallback? onBack;

  const CollapsibleCarousel({
    super.key,
    this.heroId,
    this.onBack,
    required this.title,
    required this.imageUrls,
  });

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
      gradientColors: AppColors.getCollapsibleHeaderGradient(context.c.surface),
      child: Carousel(
        imageUrls: imageUrls,
        showPagination: false,
        height: double.infinity,
      ),
    );

    return heroId == null ? carousel : Hero(tag: heroId!, child: carousel);
  }
}
