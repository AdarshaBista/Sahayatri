import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/image_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';

class PhotoGallery extends StatelessWidget {
  final List<String> imageUrls;
  final Function(String) onDelete;

  const PhotoGallery({
    this.onDelete,
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  bool get deletable => onDelete != null;
  double get padding => deletable ? 0.0 : 12.0;
  double get maxCrossAxisExtent => deletable ? 64.0 : 100.0;

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: imageUrls.isEmpty
          ? _getEmptyIndicator()
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxCrossAxisExtent,
              ),
              shrinkWrap: true,
              padding: EdgeInsets.only(left: padding, right: padding, bottom: padding),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Hero(
                    tag: imageUrls[index],
                    child: _getImage(imageUrls[index]),
                  ),
                  onTap: () => context.repository<DestinationNavService>().pushNamed(
                        Routes.kPhotoViewPageRoute,
                        arguments: PhotoViewPageArgs(
                          imageUrls: imageUrls,
                          initialPageIndex: index,
                        ),
                      ),
                );
              },
            ),
    );
  }

  Widget _getEmptyIndicator() {
    if (deletable) return const Offstage();
    return const EmptyIndicator(message: 'No photos at the moment.');
  }

  Widget _getImage(String imageUrl) {
    if (!deletable) return ImageCard(imageUrl: imageUrl);
    return Stack(
      children: [
        ImageCard(imageUrl: imageUrl),
        Positioned(
          top: 2.0,
          right: 2.0,
          child: GestureDetector(
            onTap: () => onDelete(imageUrl),
            child: const CircleAvatar(
              radius: 9.0,
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.close, size: 12.0, color: AppColors.light),
            ),
          ),
        ),
      ],
    );
  }
}
