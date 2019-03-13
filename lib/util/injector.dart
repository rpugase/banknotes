import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/domain/data_manager.dart';

class Injector {
  static final Injector _injector = Injector._internal();
  static bool _useMock = true;

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  DataManager get dataManager => DataManager(_catalogRepository());

  CatalogRepository _catalogRepository() =>
      (_useMock) ? CatalogMockRepository() : CatalogDbRepository();
}
