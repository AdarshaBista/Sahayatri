import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';

class Carousel extends StatelessWidget {
  final bool showPagination;
  final List<String> imageUrls;

  const Carousel({
    this.showPagination = true,
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 2000,
        itemWidth: double.infinity,
        itemHeight: double.infinity,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => AdaptiveImage(imageUrls[index]),
        pagination: showPagination
            ? const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  size: 6.0,
                  activeSize: 8.0,
                  color: Colors.white70,
                ),
              )
            : null,
      ),
    );
  }
}
