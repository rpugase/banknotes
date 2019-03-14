import 'package:banknotes/domain/catalog.dart';
import 'package:banknotes/presentation/catalog/bloc.dart';
import 'package:banknotes/presentation/full_catalog/bloc.dart';

class Injector {
  static final Injector _injector = Injector._internal();
  static bool _useMock = true;

  factory Injector() {
    return _injector;
  }

  Injector._internal();

  CatalogRepository _catalogRepository = (_useMock) ? CatalogMockRepository() : CatalogDbRepository();

  CatalogBloc catalogBloc() => CatalogBloc(_catalogRepository);
  FullCatalogBloc fullCatalogBloc() => FullCatalogBloc(_catalogRepository);
}
