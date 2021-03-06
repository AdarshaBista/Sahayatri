import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';

class Carousel extends StatelessWidget {
  final double width;
  final double height;
  final bool showPagination;
  final List<String> imageUrls;

  const Carousel({
    this.width,
    this.height,
    this.showPagination = true,
    @required this.imageUrls,
  }) : assert(imageUrls != null);

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
