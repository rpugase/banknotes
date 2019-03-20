import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

class Banknote {
  Banknote(this.id, this.name, this.description,
      { this.images = const [], this.ownBanknotes = const [] });

  final int id;
  final String name;
  final String description;
  final List<Image> images;
  final List<OwnBanknote> ownBanknotes;

  String getFirstBanknoteImage() {
    return images.isNotEmpty ? images.first.path : Image('resources/images/no_image_icon.png', ImageType.assets).path;
  }
}
