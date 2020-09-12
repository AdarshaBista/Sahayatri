import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';

import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';

class ImageList extends StatelessWidget {
  final List<String> imageUrls;

  const ImageList({
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: imageUrls.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10.0),
        itemBuilder: _buildImage,
      ),
    );
  }

  Widget _buildImage(BuildContext context, int index) {
    return Container(
      width: 200.0,
      child: GestureDetector(
        onTap: () => context
            .repository<DestinationNavService>()
            .pushNamed(Routes.kPhotoViewPageRoute,
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
