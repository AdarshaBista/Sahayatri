import 'dart:io';

import 'package:flutter/material.dart';

enum ImageType { asset, network, file }

class ImageUtils {
  static ImageType getImageType(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return ImageType.network;
    } else if (imageUrl.startsWith('assets')) {
      return ImageType.asset;
    } else {
      return ImageType.file;
    }
  }

  static ImageProvider getImageProvider(String imageUrl) {
    final imageType = getImageType(imageUrl);

    if (imageType == ImageType.asset) {
      return AssetImage(imageUrl);
    } else if (imageType == ImageType.network) {
      return NetworkImage(imageUrl);
    } else {
      return FileImage(File(imageUrl));
    }
  }
}
