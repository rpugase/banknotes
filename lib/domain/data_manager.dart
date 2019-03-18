import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/domain/model/catalog.dart';

class DataManager {
  DataManager(this._catalogRepository);
  final CatalogRepository _catalogRepository;

  final List<Catalog> _catalogs = [];

  Future<List<Catalog>> getAllCatalogs() async {
    if (_catalogs.isEmpty) {
      _catalogs.addAll(await _catalogRepository.getAllCatalogs());
    }
    return _catalogs;
  }

  Future<List<Catalog>> getFavouriteCatalogs() async {
    if (_catalogs.isEmpty) {
      _catalogs.addAll(await _catalogRepository.getAllCatalogs());
    }
    return _catalogs.where((catalog) => catalog.isFavourite).toList();
  }

  Future<List<Catalog>> replaceCatalogsPositions(Catalog oldCatalog, Catalog newCatalog) async {
    assert(_catalogs.isNotEmpty);
    _catalogRepository.replaceCatalogsPositions(oldCatalog, newCatalog);

    _catalogs.insert(_catalogs.indexOf(newCatalog), _catalogs.removeAt(_catalogs.indexOf(oldCatalog)));
    return _catalogs.where((catalog) => catalog.isFavourite).toList();
  }
}
