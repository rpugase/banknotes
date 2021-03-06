import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/own_banknote.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

abstract class BanknoteRepository {
  Future<List<BanknoteEntity>> getBanknotes(int emissionId);
}

class BanknoteDBRepository implements BanknoteRepository {
  BanknoteDBRepository(this.banknoteBean);
  final BanknoteBean banknoteBean;

  Future<List<BanknoteEntity>> getBanknotes(int emissionId) => throw UnimplementedError();
}

class BanknoteMockRepository implements BanknoteRepository {

  Description _description = Description.test();

  List<BanknoteEntity> get banknotes => [
    BanknoteEntity.make(0, "1 uah", _description.text, _description.year, _description.printer, _description.entryDate, 1, [], [])..id = 0,
    BanknoteEntity.make(0, "2 uah", _description.text, _description.year, _description.printer, _description.entryDate, 1, [], [
      OwnBanknoteEntity.make(1, QualityType.fr.toString(), 12.5, Currency().code.toString(), 'comment', [], DateTime.now()),
      OwnBanknoteEntity.make(2, QualityType.fr.toString(), 2.5, Currency().code.toString(), 'comment', [], DateTime.now()),
      OwnBanknoteEntity.make(3, QualityType.fr.toString(), 1.3, Currency().code.toString(), 'comment', [], DateTime.now()),
      OwnBanknoteEntity.make(4, QualityType.fr.toString(), 4.2, Currency().code.toString(), 'comment', [], DateTime.now()),
    ])..id = 1,
    BanknoteEntity.make(0, "5 uah", _description.text, _description.year, _description.printer, _description.entryDate, 2, [], [])..id = 2,
    BanknoteEntity.make(0, "10 uah", _description.text, _description.year, _description.printer, _description.entryDate, 2, [], [])..id = 3,
    BanknoteEntity.make(0, "20 uah", _description.text, _description.year, _description.printer, _description.entryDate, 2, [], [])..id = 4,
    BanknoteEntity.make(0, "50 uah", _description.text, _description.year, _description.printer, _description.entryDate, 3, [], [])..id = 5,
    BanknoteEntity.make(0, "100 uah", _description.text, _description.year, _description.printer, _description.entryDate, 4, [], [])..id = 6,
    BanknoteEntity.make(0, "500 uah", _description.text, _description.year, _description.printer, _description.entryDate, 4, [], [])..id = 7,
  ];

  @override
  Future<List<BanknoteEntity>> getBanknotes(int emissionId) async {
    await Future.delayed(Duration(seconds: 1));

    return banknotes;
  }
}