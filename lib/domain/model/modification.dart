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
}
