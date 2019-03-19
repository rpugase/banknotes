import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

abstract class BanknoteRepository {
  Future<List<Banknote>> getBanknotes(int modificationId);
}

class BanknoteDBRepository implements BanknoteRepository {
  Future<List<Banknote>> getBanknotes(int modificationId) => throw UnimplementedError();
}

class BanknoteMockRepository implements BanknoteRepository {

  List<Banknote> get banknotes => [
    Banknote(0, "1 uah", "desc", ownBanknotes: []),
    Banknote(1, "2 uah", "desc", ownBanknotes: [OwnBanknote(0, QualityType.good, price: 12.5, currency: Currency(), date: DateTime.now())]),
    Banknote(2, "5 uah", "desc", ownBanknotes: []),
    Banknote(3, "10 uah", "desc", ownBanknotes: []),
    Banknote(4, "20 uah", "desc", ownBanknotes: []),
    Banknote(5, "50 uah", "desc", ownBanknotes: []),
    Banknote(6, "100 uah", "desc", ownBanknotes: []),
    Banknote(7, "500 uah", "desc", ownBanknotes: []),
  ];

  @override
  Future<List<Banknote>> getBanknotes(int modificationId) async {
    await Future.delayed(Duration(seconds: 1));

    return banknotes;
  }
}