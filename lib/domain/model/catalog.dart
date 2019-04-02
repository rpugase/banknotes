import 'package:banknotes/data/model/catalog.dart';
import 'package:banknotes/domain/model/emission.dart';
import 'package:banknotes/domain/model/image.dart';

class Catalog {
  Catalog(this.id, this.name, this.image, {this.isFavourite = false}) : emissions = [];

  final int id;
  final String name;
  final ImageModel image;
  final List<Emission> emissions;
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
        image = ImageModel(catalogEntity.image, ImageType.assets),
        isFavourite = catalogEntity.isFavourite,
        emissions = catalogEntity.emissions.map((emission) => Emission.fromEntity(emission)).toList();

  CatalogEntity toEntity() => CatalogEntity.make(name, image.path, isFavourite,
      emissions.map((emission) => emission.toEntity(id)).toList());
}
