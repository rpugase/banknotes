import 'package:banknotes/data/model/catalog.dart';
import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/modification.dart';

class Catalog {
  Catalog(this.id, this.name, this.image, {this.isFavourite = false}) : modifications = [];

  final int id;
  final String name;
  final Image image;
  final List<Modification> modifications;
  bool isFavourite;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Catalog &&
              runtimeType == other.runtimeType &&
              id == other.id;

  Catalog.fromEntity(CatalogEntity catalogEntity) :
        id = catalogEntity.id,
        name = catalogEntity.name,
        image = Image(catalogEntity.image, ImageType.assets),
        isFavourite = catalogEntity.isFavourite,
        modifications = catalogEntity.emissions.map((emission) => Modification.fromEntity(emission)).toList();

  CatalogEntity toEntity() => CatalogEntity.make(name, image.path, isFavourite,
      modifications.map((modification) => modification.toEntity()).toList());
}
