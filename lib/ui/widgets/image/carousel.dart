import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';

class Carousel extends StatelessWidget {
  final bool showPagination;
  final List<String> imageUrls;
  final double? width;
  final double? height;

  const Carousel({
    super.key,
    required this.imageUrls,
    this.showPagination = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.3,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 2000,
        itemWidth: double.infinity,
        itemHeight: double.infinity,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => AdaptiveImage(imageUrls[index]),
        pagination: showPagination
            ? SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  size: 6.0,
                  activeSize: 8.0,
                  color: context.c.surface,
                ),
              )
            : null,
      ),
    );
  }
}
