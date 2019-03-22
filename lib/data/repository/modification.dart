import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/data/model/own_banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

abstract class EmissionRepository {

  /// Get all modifications with Banknotes and OwnBanknotes.
  Future<List<EmissionEntity>> getFullModifications(int catalogId);
}

class ModificationDbRepository implements EmissionRepository {
  ModificationDbRepository(this.emissionBean);
  final EmissionBean emissionBean;

  @override
  Future<List<EmissionEntity>> getFullModifications(int catalogId) => throw UnimplementedError();
}

class ModificationMockRepository implements EmissionRepository {

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

  List<EmissionEntity> get modifications => [
    EmissionEntity.make("1994", banknotes)..id = 0,
    EmissionEntity.make("1997", banknotes)..id = 1,
    EmissionEntity.make("2001", banknotes)..id = 2,
    EmissionEntity.make("2008", banknotes)..id = 3,
    EmissionEntity.make("2010", banknotes)..id = 4,
    EmissionEntity.make("2015", banknotes)..id = 5,
  ];

  @override
  Future<List<EmissionEntity>> getFullModifications(int catalogId) async {
    await Future.delayed(Duration(seconds: 1));

    return modifications;
  }
}