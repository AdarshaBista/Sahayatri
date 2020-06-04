import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sahayatri/ui/shared/widgets/close_icon.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/loading_indicator.dart';

class PhotoViewPage extends StatelessWidget {
  final PhotoViewPageArgs args;

  const PhotoViewPage({
    @required this.args,
  }) : assert(args != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const ClampingScrollPhysics(),
            pageController: PageController(
              keepPage: true,
              initialPage: args.initialPageIndex,
            ),
            loadingBuilder: (context, event) => const LoadingIndicator(),
            loadFailedChild: const ErrorIndicator(
              message: "Couldn't load photo",
            ),
            itemCount: args.imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(args.imageUrls[index]),
                heroAttributes:
                    PhotoViewHeroAttributes(tag: args.imageUrls[index]),
                maxScale: PhotoViewComputedScale.covered * 2.5,
                minScale: PhotoViewComputedScale.contained * 0.6,
                initialScale: PhotoViewComputedScale.contained * 1.0,
              );
            },
          ),
          const Positioned(
            top: 16.0,
            right: 16.0,
            child: SafeArea(child: const CloseIcon()),
          ),
        ],
      ),
    );
  }
}

class PhotoViewPageArgs {
  final int initialPageIndex;
  final List<String> imageUrls;

  const PhotoViewPageArgs({
    @required this.initialPageIndex,
    @required this.imageUrls,
  })  : assert(initialPageIndex != null),
        assert(imageUrls != null);
}
