class Image {
  Image(this.path, this.imageType);

  final String path;
  final _ImageType imageType;
}

enum _ImageType { network, assets, device }
