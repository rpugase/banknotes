import 'package:banknotes/data/model/image.dart';
import 'package:flutter/foundation.dart';

class ImageModel {
  ImageModel(this.path, this.imageType, [this.main = true]);

  final String path;
  final ImageType imageType;
  final bool main;

  ImageModel.fromEntity(ImageEntity entity) :
        path = entity.path,
        imageType = ImageType.values.firstWhere((type) => describeEnum(type) == entity.type),
        main = entity.main;

  ImageEntity toEntity() => ImageEntity.make(path, main, imageType.toString());
}

enum ImageType { assets, device }
