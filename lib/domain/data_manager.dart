import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/domain/model/catalog.dart';

class DataManager {
  const DataManager(this._catalogRepository);

  final CatalogRepository _catalogRepository;

  Future<List<Catalog>> getFavouriteCatalogs() async => _catalogRepository.getFavouriteCatalogs();
  Future<List<Catalog>> getAllCatalogs() async => _catalogRepository.getAllCatalogs();
}
