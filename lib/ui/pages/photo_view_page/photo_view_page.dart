import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/image_utils.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sahayatri/ui/widgets/buttons/exit_button.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

class PhotoViewPage extends StatelessWidget {
  final PhotoViewPageArgs args;

  const PhotoViewPage({
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            enableRotation: true,
            gaplessPlayback: true,
            scrollPhysics: const ClampingScrollPhysics(),
            loadingBuilder: (context, event) => const CircularBusyIndicator(),
            pageController: PageController(initialPage: args.initialPageIndex),
            itemCount: args.imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    ImageUtils.getImageProvider(args.imageUrls[index]),
                heroAttributes:
                    PhotoViewHeroAttributes(tag: args.imageUrls[index]),
                maxScale: PhotoViewComputedScale.covered * 2.5,
                minScale: PhotoViewComputedScale.contained * 0.6,
                initialScale: PhotoViewComputedScale.contained * 1.0,
                errorBuilder: (_, __, ___) => const Center(
                  child: ErrorIndicator(message: "Couldn't load photo!"),
                ),
              );
            },
          ),
          const Positioned(
            top: 16.0,
            right: 16.0,
            child: SafeArea(child: ExitButton()),
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
    required this.initialPageIndex,
    required this.imageUrls,
  });
}
