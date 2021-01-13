import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';

import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';

class ImageList extends StatelessWidget {
  final List<String> imageUrls;

  const ImageList({
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: imageUrls.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10.0),
        itemBuilder: (_, index) => _buildImage(index),
      ),
    );
  }

  Widget _buildImage(int index) {
    return SizedBox(
      width: 200.0,
      child: GestureDetector(
        onTap: () => locator<DestinationNavService>().pushNamed(Routes.photoViewPageRoute,
            arguments: PhotoViewPageArgs(
              imageUrls: imageUrls,
              initialPageIndex: index,
            )),
        child: Hero(
          tag: imageUrls[index],
          child: CustomCard(
            borderRadius: 10.0,
            child: AdaptiveImage(imageUrls[index]),
          ),
        ),
      ),
    );
  }
}
