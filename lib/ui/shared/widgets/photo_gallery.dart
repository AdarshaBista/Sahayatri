import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';

import 'package:sahayatri/ui/shared/widgets/image_card.dart';

class PhotoGallery extends StatelessWidget {
  final List<String> imageUrls;

  const PhotoGallery({
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      shrinkWrap: true,
      maxCrossAxisExtent: 120.0,
      padding: const EdgeInsets.all(12.0),
      physics: const NeverScrollableScrollPhysics(),
      children: imageUrls.map(
        (url) {
          return GestureDetector(
            child: ImageCard(imageUrl: url),
            onTap: () {
              context.repository<RootNavService>().pushNamed(
                    Routes.kPhotoViewPageRoute,
                    arguments: PhotoViewPageArgs(
                      initialPageIndex: imageUrls.indexOf(url),
                      imageUrls: imageUrls,
                    ),
                  );
            },
          );
        },
      ).toList(),
    );
  }
}
