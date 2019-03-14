import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/presentation/catalog/bloc.dart';
import 'package:banknotes/presentation/full_catalog/bloc.dart';

class Injector {
  static final Injector _injector = Injector._internal();
  static bool _useMock = true;

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  CatalogRepository _catalogRepository() =>
      (_useMock) ? CatalogMockRepository() : CatalogDbRepository();

  DataManager get _dataManager => DataManager(_catalogRepository());

  CatalogBloc catalogBloc() => CatalogBloc(_dataManager);
  FullCatalogBloc fullCatalogBloc() => FullCatalogBloc(_dataManager);
}
