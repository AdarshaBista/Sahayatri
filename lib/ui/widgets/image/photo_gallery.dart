import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/images.dart';
import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/image/image_card.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';

class PhotoGallery extends StatefulWidget {
  final List<String> imageUrls;
  final Function(String) onDelete;

  const PhotoGallery({
    this.onDelete,
    @required this.imageUrls,
  }) : assert(imageUrls != null);

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  static const int crossAxisCount = 4;
  final List<StaggeredTile> _staggeredTiles = [];

  bool get deletable => widget.onDelete != null;
  double get padding => deletable ? 0.0 : 12.0;

  @override
  void initState() {
    super.initState();
    if (!deletable) _populateStaggeredGridLayout();
  }

  void _populateStaggeredGridLayout() {
    int yCount = 2;
    int xRemaining = crossAxisCount;

    for (int i = 0; i < widget.imageUrls.length; ++i) {
      // Move onto the next row.
      if (xRemaining <= 0) {
        xRemaining = crossAxisCount;
        yCount = math.Random().nextInt(2) + 1;
      }

      final xCount = (math.Random().nextInt(xRemaining) % crossAxisCount) + 1;
      final effectiveXCount = math.min(xCount, crossAxisCount - 1);
      xRemaining -= effectiveXCount;

      _staggeredTiles.add(StaggeredTile.count(effectiveXCount, yCount));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: widget.imageUrls.isEmpty
          ? _buildEmptyIndicator()
          : deletable
              ? _buildGrid()
              : _buildStaggeredGrid(),
    );
  }

  Widget _buildEmptyIndicator() {
    if (deletable) return const Offstage();
    return const EmptyIndicator(
      imageUrl: Images.imagesEmpty,
      message: 'No photos at the moment.',
    );
  }

  Widget _buildStaggeredGrid() {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      padding: EdgeInsets.only(left: padding, right: padding, bottom: padding),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: _buildItem,
      itemCount: widget.imageUrls.length,
      staggeredTileBuilder: (index) => _staggeredTiles[index],
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 64.0,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.only(left: padding, right: padding, bottom: padding),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.imageUrls.length,
      itemBuilder: _buildItem,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      child: Hero(
        tag: widget.imageUrls[index],
        child: _buildImage(index),
      ),
      onTap: () => locator<DestinationNavService>().pushNamed(
        Routes.photoViewPageRoute,
        arguments: PhotoViewPageArgs(
          imageUrls: widget.imageUrls,
          initialPageIndex: index,
        ),
      ),
    );
  }

  Widget _buildImage(int index) {
    final imageUrl = widget.imageUrls[index];
    if (!deletable) return ImageCard(imageUrl: imageUrl);
    return Stack(
      children: [
        ImageCard(imageUrl: imageUrl),
        Positioned(
          top: 2.0,
          right: 2.0,
          child: GestureDetector(
            onTap: () => widget.onDelete(imageUrl),
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
