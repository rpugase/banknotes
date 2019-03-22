import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/own_banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

abstract class BanknoteRepository {
  Future<List<BanknoteEntity>> getBanknotes(int modificationId);
}

class BanknoteDBRepository implements BanknoteRepository {
  BanknoteDBRepository(this.banknoteBean);
  final BanknoteBean banknoteBean;

  Future<List<BanknoteEntity>> getBanknotes(int modificationId) => throw UnimplementedError();
}

class BanknoteMockRepository implements BanknoteRepository {

  List<BanknoteEntity> get banknotes => [
    BanknoteEntity.make("1 uah", "desc", [], [])..id = 0,
    BanknoteEntity.make("2 uah", "desc", [], [OwnBanknoteEntity.make(QualityType.good.toString(), 12.5, Currency().code.toString(), 'comment', [], DateTime.now())])..id = 1,
    BanknoteEntity.make("5 uah", "desc", [], [])..id = 2,
    BanknoteEntity.make("10 uah", "desc", [], [])..id = 3,
    BanknoteEntity.make("20 uah", "desc", [], [])..id = 4,
    BanknoteEntity.make("50 uah", "desc", [], [])..id = 5,
    BanknoteEntity.make("100 uah", "desc", [], [])..id = 6,
    BanknoteEntity.make("500 uah", "desc", [], [])..id = 7,
  ];

  @override
  Future<List<BanknoteEntity>> getBanknotes(int modificationId) async {
    await Future.delayed(Duration(seconds: 1));

    return banknotes;
  }
}