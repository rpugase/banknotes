import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/data/repository/modification.dart';
import 'package:banknotes/data/repository/banknote.dart';
import 'package:banknotes/domain/data_manager.dart';

class Injector {
  static final Injector _injector = Injector._internal();
  static bool _useMock = true;

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  static CatalogRepository get _catalogRepository
  => (_useMock) ? CatalogMockRepository() : CatalogDbRepository();

  static ModificationRepository get _modificationRepository
  => (_useMock) ? ModificationMockRepository() : ModificationDbRepository();

  static BanknoteMockRepository get _banknoteRepository
  => (_useMock) ? BanknoteMockRepository() : BanknoteDBRepository();

  DataManager dataManager = DataManager(_catalogRepository, _modificationRepository, _banknoteRepository);

}
