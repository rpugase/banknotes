import 'package:banknotes/data/model/image.dart';

class Image {
  Image(this.path, this.imageType, [this.main = true]);

  final String path;
  final ImageType imageType;
  final bool main;

  Image.fromEntity(ImageEntity entity) :
        path = entity.path,
        imageType = ImageType.values.firstWhere((type) => type.toString() == entity.type),
        main = entity.main;

  ImageEntity toEntity() => ImageEntity.make(path, main, imageType.toString());
}

enum ImageType { assets, device }
