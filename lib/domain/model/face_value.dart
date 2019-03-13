import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/image.dart';

class FaceValue {
  FaceValue(this.id, this.name, this.description,
      {this.images, this.banknotes});

  final int id;
  final String name;
  final String description;
  final List<Image> images;
  final List<Banknote> banknotes;
}
