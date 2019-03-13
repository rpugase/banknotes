import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/modification.dart';

class Catalog {
  Catalog(this.id, this.name, this.image, [this.modifications]);

  final int id;
  final String name;
  final Image image;
  final List<Modification> modifications;
}
