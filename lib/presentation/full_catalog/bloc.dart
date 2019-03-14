import 'dart:async';

import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/catalog.dart';

class FullCatalogBloc {
  FullCatalogBloc(this._dataManager);

  final DataManager _dataManager;

  final _catalogStreamController = StreamController<FullCatalogState>();
  Stream<FullCatalogState> get catalogStream => _catalogStreamController.stream;

  void loadCatalogs() {
    _catalogStreamController.sink.add(FullCatalogState._loading());
    _dataManager.getAllCatalogs().then((List<Catalog> catalogs) {
      _catalogStreamController.sink.add(
          FullCatalogState._catalogsData(catalogs));
    });
  }

  void dispose() {
    _catalogStreamController.close();
  }
}

class FullCatalogState {
  FullCatalogState();
  factory FullCatalogState._loading() = CatalogLoadingState;
  factory FullCatalogState._catalogsData(List<Catalog> catalogs) = CatalogDataState;
}

class CatalogInitState extends FullCatalogState {}
class CatalogLoadingState extends FullCatalogState {}
class CatalogDataState extends FullCatalogState {
  CatalogDataState(this.catalogs);
  List<Catalog> catalogs = [];
}
