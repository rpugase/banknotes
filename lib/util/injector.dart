import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/catalog.dart';
import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/data/repository/banknote.dart';
import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/data/repository/emission.dart';
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
//    if (sqfliteAdapter != null) throw Exception('Method init() need to call one time!');

    if (sqfliteAdapter != null) Injector.sqfliteAdapter = sqfliteAdapter;
  }

  static SqfliteAdapter sqfliteAdapter;

  /// Bean
  static CatalogBean get catalogBean => CatalogBean(sqfliteAdapter);
  static EmissionBean get _emissionBean => EmissionBean(sqfliteAdapter);
  static BanknoteBean get _banknoteBean => BanknoteBean(sqfliteAdapter);

  /// Repository
  static CatalogRepository get _catalogRepository
  => (_useMock) ? CatalogMockRepository() : CatalogDbRepository(catalogBean);

  static EmissionRepository get _emissionRepository
  => (_useMock) ? EmissionMockRepository() : EmissionDbRepository(_emissionBean);

  static BanknoteMockRepository get _banknoteRepository
  => (_useMock) ? BanknoteMockRepository() : BanknoteDBRepository(_banknoteBean);

  /// DataManager
  DataManager dataManager = DataManager(_catalogRepository, _emissionRepository, _banknoteRepository);

}
