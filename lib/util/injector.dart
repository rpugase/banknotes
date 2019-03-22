import 'package:banknotes/data/model/catalog.dart';
import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/data/repository/modification.dart';
import 'package:banknotes/data/repository/banknote.dart';
import 'package:banknotes/domain/data_manager.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class Injector {
  static final Injector _injector = Injector._internal();
  static bool _useMock = true;

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  void init(SqfliteAdapter sqfliteAdapter) {
    if (_sqfliteAdapter != null) throw Exception('Method init() need to call one time!');

    _sqfliteAdapter = sqfliteAdapter;
  }

  static SqfliteAdapter _sqfliteAdapter;

  /// Bean
  static CatalogBean get _catalogBean => CatalogBean(_sqfliteAdapter);
  static EmissionBean get _emissionBean => EmissionBean(_sqfliteAdapter);

  /// Repository
  static CatalogRepository get _catalogRepository
  => (_useMock) ? CatalogMockRepository() : CatalogDbRepository(_catalogBean);

  static EmissionRepository get _modificationRepository
  => (_useMock) ? ModificationMockRepository() : ModificationDbRepository(_emissionBean);

  static BanknoteMockRepository get _banknoteRepository
  => (_useMock) ? BanknoteMockRepository() : BanknoteDBRepository();

  /// DataManager
  DataManager dataManager = DataManager(_catalogRepository, _modificationRepository);

}
