import 'package:banknotes/domain/catalog.dart';
import 'package:banknotes/presentation/full_catalog/bloc.dart';

class Injector {
  static final Injector _injector = Injector._internal();
  static bool _useMock = true;

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  CatalogRepository catalogRepository = (_useMock) ? CatalogMockRepository() : CatalogDbRepository();

  FullCatalogBloc fullCatalogBloc() => FullCatalogBloc(catalogRepository);
}
