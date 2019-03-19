import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/modification.dart';

class Catalog {
  Catalog(this.id, this.name, this.image, {this.isFavourite = false});

  final int id;
  final String name;
  final Image image;
  final List<Modification> modifications = [];
  bool isFavourite;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Catalog &&
              runtimeType == other.runtimeType &&
              id == other.id;
}
