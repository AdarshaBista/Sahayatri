import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/utils/image_utils.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';

import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';

class ImagesGrid extends StatelessWidget {
  final List<String> imageUrls;

  static const Map<int, List<StaggeredTile>> _layout = {
    2: [
      StaggeredTile.count(3, 4),
      StaggeredTile.count(3, 4),
    ],
    3: [
      StaggeredTile.count(6, 3),
      StaggeredTile.count(3, 3),
      StaggeredTile.count(3, 3),
    ],
    4: [
      StaggeredTile.count(4, 6),
      StaggeredTile.count(2, 2),
      StaggeredTile.count(2, 2),
      StaggeredTile.count(2, 2),
    ],
    5: [
      StaggeredTile.count(3, 3),
      StaggeredTile.count(3, 3),
      StaggeredTile.count(2, 2),
      StaggeredTile.count(2, 2),
      StaggeredTile.count(2, 2),
    ],
  };

  const ImagesGrid({
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.length == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _buildImage(0),
      );
    }

    final maxImages = math.min(imageUrls.length, _layout.length + 1);
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      itemCount: maxImages,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      staggeredTileBuilder: (int index) => _layout[maxImages]![index],
      itemBuilder: (context, index) => _buildItem(context, index, maxImages),
    );
  }

  Widget _buildItem(BuildContext context, int index, int maxImages) {
    if (index + 1 < maxImages) return _buildImage(index);

    final remaining = imageUrls.length - maxImages;
    if (remaining == 0) return _buildImage(index);

    return _buildRemaining(remaining, index);
  }

  Widget _buildRemaining(int remaining, int index) {
    return Hero(
      tag: imageUrls[index],
      child: ElevatedCard(
        child: GestureDetector(
          onTap: () => _navigateToPhotoViewPage(index),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ImageUtils.getImageProvider(imageUrls[index]),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.darkFaded,
                  BlendMode.srcATop,
                ),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: Text(
                '+$remaining',
                style: AppTextStyles.headline1.light.thin,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(int index) {
    return Hero(
      tag: imageUrls[index],
      child: ElevatedCard(
        child: GestureDetector(
          onTap: () => _navigateToPhotoViewPage(index),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 80.0,
              maxHeight: 500.0,
            ),
            child: AdaptiveImage(imageUrls[index]),
          ),
        ),
      ),
    );
  }

  void _navigateToPhotoViewPage(int index) {
    locator<DestinationNavService>().pushNamed(Routes.photoViewPageRoute,
        arguments: PhotoViewPageArgs(
          imageUrls: imageUrls,
          initialPageIndex: index,
        ));
  }
}
