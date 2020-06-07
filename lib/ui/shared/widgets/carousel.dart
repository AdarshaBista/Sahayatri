import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

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
      height: 240.0,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 2000,
        pagination: showPagination ? const SwiperPagination() : null,
        itemWidth: double.infinity,
        itemHeight: double.infinity,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => Image.asset(
          imageUrls[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
