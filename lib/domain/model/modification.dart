import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/domain/model/banknote.dart';

class Modification {
  Modification(this.id, this.name, [this.banknotes]);

  final int id;
  final String name;
  final Map<int, List<Banknote>> banknotes;

  int get banknotesLength => banknotes.values
      .map((banknotes) => banknotes.length)
      .reduce((value, element) => value + element);

  int get ownBanknotesLength => banknotes.values
      .map((banknotes) => banknotes.where((banknote) => banknote.ownBanknotes.isNotEmpty).length)
      .reduce((value, element) => value + element);

  Modification.fromEntity(EmissionEntity entity) :
        id = entity.id,
        name = entity.shortName,
        banknotes = Banknote.toMap(entity.banknotes);

  EmissionEntity toEntity(int catalogId) => EmissionEntity.make(
      catalogId,
      name,
      banknotes.values.reduce((value, element) {
        value.addAll(element);
        return value;
      }).map((banknote) => banknote.toEntity(id)).toList()
  );
}
