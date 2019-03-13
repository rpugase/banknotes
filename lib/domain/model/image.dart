class Image {
  Image(this.path, this.imageType);

  final String path;
  final ImageType imageType;
}

enum ImageType { network, assets, device }
