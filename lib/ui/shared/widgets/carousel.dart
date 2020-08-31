import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';

class Carousel extends StatelessWidget {
  final double height;
  final bool showPagination;
  final List<String> imageUrls;

  const Carousel({
    this.height,
    this.showPagination = true,
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.3,
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
