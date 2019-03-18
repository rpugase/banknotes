import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/presentation/full_catalog/bloc.dart';

class Injector {
  static final Injector _injector = Injector._internal();
  static bool _useMock = true;

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  static CatalogRepository get catalogRepository => (_useMock) ? CatalogMockRepository() : CatalogDbRepository();

  DataManager dataManager = DataManager(catalogRepository);

  FullCatalogBloc fullCatalogBloc() => FullCatalogBloc(catalogRepository);
}
