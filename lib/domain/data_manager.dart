import 'package:banknotes/data/model/catalog.dart';
import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/data/repository/modification.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/modification.dart';
import 'package:banknotes/data/repository/banknote.dart';

class DataManager {
  DataManager(this._catalogRepository, this._modificationRepository, this._banknoteRepository);
  final CatalogRepository _catalogRepository;
  final EmissionRepository _modificationRepository;
  final BanknoteRepository _banknoteRepository;

  final List<Catalog> _catalogs = [];

  Future<List<Catalog>> getAllCatalogs() async {
    if (_catalogs.isEmpty) {
      final List<CatalogEntity> catalogs = await _catalogRepository.getAllCatalogs();
      _catalogs.addAll(catalogs.map((catalog) => Catalog.fromEntity(catalog)).toList());
    }
    return _catalogs;
  }

  Future<List<Banknote>> getBanknotes(Modification modification) async {
    if (modification != null && modification.banknotes.isEmpty) {
       modification.banknotes.addAll(await _banknoteRepository.getBanknotes(modification.id));
    }

    return modification.banknotes;
  }

  Future<List<Catalog>> getFavouriteCatalogs() async {
    if (_catalogs.isEmpty) {
      final List<CatalogEntity> catalogs = await _catalogRepository.getAllCatalogs();
      _catalogs.addAll(catalogs.map((catalog) => Catalog.fromEntity(catalog)).toList());
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
    if (catalog != null && catalog.modifications.isEmpty) {
      final List<EmissionEntity> emissions = await _modificationRepository.getFullModifications(catalog.id);
      catalog.modifications.addAll(emissions.map((emission) => Modification.fromEntity(emission)).toList());
    }

    return catalog.modifications;
  }

  Future changeFavouriteStatus(Catalog country) async {
    // TODO: change status in DB
    country.isFavourite = !country.isFavourite;
  }
}
