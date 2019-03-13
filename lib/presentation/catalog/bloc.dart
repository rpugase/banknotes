import 'dart:async';

import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/catalog.dart';

class CatalogBloc {
  CatalogBloc(this._dataManager);

  final DataManager _dataManager;

  final _catalogStreamController = StreamController<CatalogState>();
  Stream<CatalogState> get catalogStream => _catalogStreamController.stream;

  void loadCatalogs() {
    _catalogStreamController.sink.add(CatalogState._loading());
    _dataManager.getFavouriteCatalogs().then((List<Catalog> catalogs) {
      _catalogStreamController.sink.add(
          (catalogs.isEmpty) ? CatalogState._emptyData() : CatalogState._catalogsData(catalogs));
    });
  }

  void dispose() {
    _catalogStreamController.close();
  }
}

class CatalogState {
  CatalogState();
  factory CatalogState._loading() = CatalogLoadingState;
  factory CatalogState._emptyData() = CatalogEmptyDataState;
  factory CatalogState._catalogsData(List<Catalog> catalogs) = CatalogDataState;
}

class CatalogLoadingState extends CatalogState {}
class CatalogEmptyDataState extends CatalogState {}
class CatalogDataState extends CatalogState {
  CatalogDataState(this.catalogs);
  List<Catalog> catalogs = [];
}
