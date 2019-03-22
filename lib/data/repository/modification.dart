import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/modification.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

abstract class ModificationRepository {

  /// Get all modifications with Banknotes and OwnBanknotes.
  Future<List<Modification>> getFullModifications(int catalogId);
}

class ModificationDbRepository implements ModificationRepository {
  ModificationDbRepository(this.emissionBean);
  final EmissionBean emissionBean;

  @override
  Future<List<Modification>> getFullModifications(int catalogId) => throw UnimplementedError();
}

class ModificationMockRepository implements ModificationRepository {

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
  
  List<Modification> get modifications => [
    Modification(0, "1994", banknotes),
    Modification(1, "1997", banknotes),
    Modification(2, "2001", banknotes),
    Modification(3, "2008", banknotes),
    Modification(4, "2010", banknotes),
    Modification(5, "2015", banknotes),
  ];
  
  @override
  Future<List<Modification>> getFullModifications(int catalogId) async {
    await Future.delayed(Duration(seconds: 1));

    return modifications;
  }
  
}