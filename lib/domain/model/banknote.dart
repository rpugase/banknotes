import 'package:banknotes/data/model/banknote.dart';
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

  Banknote.fromEntity(BanknoteEntity entity) :
        id = entity.id,
        name = entity.name,
        description = entity.description,
        images = entity.images.map((image) => Image.fromEntity(image)).toList(),
        ownBanknotes = entity.ownBanknotes.map((ownBanknote) => OwnBanknote.fromEntity(ownBanknote)).toList();

  BanknoteEntity toEntity() => BanknoteEntity.make(
      name,
      description,
      images.map((image) => image.toEntity()).toList(),
      ownBanknotes.map((ownBanknote) => ownBanknote.toEntity()).toList()
  );
}
