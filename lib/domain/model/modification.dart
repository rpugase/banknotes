import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/domain/model/banknote.dart';

class Modification {
  Modification(this.id, this.name, [this.banknotes]);

  final int id;
  final String name;
  final List<Banknote> banknotes;

  int get banknotesLength => banknotes.length;
  int get ownBanknotesLength => banknotes.where((banknote) => banknote.ownBanknotes.isNotEmpty).length;

  Modification.fromEntity(EmissionEntity entity) :
        id = entity.id,
        name = entity.shortName,
        banknotes = entity.banknotes.map((banknote) => Banknote.fromEntity(banknote)).toList();

  EmissionEntity toEntity(int catalogId) => EmissionEntity.make(
      catalogId,
      name,
      banknotes.map((banknote) => banknote.toEntity(id)).toList()
  );
}
