import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';

import 'package:sahayatri/ui/shared/widgets/image_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

class PhotoGallery extends StatelessWidget {
  final List<String> imageUrls;

  const PhotoGallery({
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120.0,
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.all(12.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ImageCard(imageUrl: imageUrls[index]),
            onTap: () => context.repository<DestinationNavService>().pushNamed(
                  Routes.kPhotoViewPageRoute,
                  arguments: PhotoViewPageArgs(
                    initialPageIndex: imageUrls.indexOf(imageUrls[index]),
                    imageUrls: imageUrls,
                  ),
                ),
          );
        },
      ),
    );
  }
}
