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
}
