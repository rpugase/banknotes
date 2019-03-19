import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/modification.dart';

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
    _catalogRepository.replaceCatalogsPositions(oldCatalog.id, newCatalog.id);

    _catalogs.insert(_catalogs.indexOf(newCatalog), _catalogs.removeAt(_catalogs.indexOf(oldCatalog)));
    return _catalogs.where((catalog) => catalog.isFavourite).toList();
  }

  Future<List<Modification>> getModifications(Catalog catalog) async {
    final Catalog catalog = _catalogs.firstWhere((catalog) => catalog == catalog);
    if (catalog != null && catalog.modifications.isEmpty) {
      catalog.modifications.addAll(await _catalogRepository.getFullCatalog(catalog.id));
    }

    return catalog.modifications;
  }

  void changeFavouriteStatus(Catalog country) {
    country.isFavourite = !country.isFavourite; // todo change status in the DB
  }
}