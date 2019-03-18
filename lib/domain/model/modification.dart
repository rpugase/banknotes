import 'package:banknotes/domain/model/banknote.dart';

class Modification {
  Modification(this.id, this.name, [this.banknotes]);

  final int id;
  final String name;
  final List<Banknote> banknotes;

  int get banknotesLength => banknotes.length;
  int get ownBanknotesLength => banknotes.where((banknote) => banknote.ownBanknotes.isNotEmpty).length;
}
