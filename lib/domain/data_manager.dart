import 'dart:math';

import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/catalog.dart';
import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/data/repository/banknote.dart';
import 'package:banknotes/data/repository/catalog.dart';
import 'package:banknotes/data/repository/emission.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/emission.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

class DataManager {
  DataManager(this._catalogRepository, this._emissionRepository, this._banknoteRepository);
  final CatalogRepository _catalogRepository;
  final EmissionRepository _emissionRepository;
  final BanknoteRepository _banknoteRepository;

  final List<Catalog> _catalogs = [];

  Future<List<Catalog>> getAllCatalogs() async {
    if (_catalogs.isEmpty) {
      final List<CatalogEntity> catalogs = await _catalogRepository.getAllCatalogs();
      _catalogs.addAll(catalogs.map((catalog) => Catalog.fromEntity(catalog)).toList());
    }
    return _catalogs;
  }

  Future<Map<int, List<Banknote>>> getBanknotes(Emission emission) async {
    if (emission != null && emission.banknotes.isEmpty) {
      final List<BanknoteEntity> banknotes = await _banknoteRepository.getBanknotes(emission.id);
      final Map<int, List<Banknote>> map = {};
      banknotes.forEach((banknote) {
        if (map[banknote.parentId] == null) {
          map[banknote.parentId] = [Banknote.fromEntity(banknote)];
        } else {
          map[banknote.parentId].add(Banknote.fromEntity(banknote));
        }
      });

      emission.banknotes.addAll(map);
    }

    return emission.banknotes;
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

  Future<List<Emission>> getEmissions(Catalog catalog) async {
    if (catalog != null && catalog.emissions.isEmpty) {
      final List<EmissionEntity> emissions = await _emissionRepository.getFullEmissions(catalog.id);
      catalog.emissions.addAll(emissions.map((emission) => Emission.fromEntity(emission)).toList());
    }

    return catalog.emissions;
  }

  Future<List<OwnBanknote>> replaceOwnBanknotesPositions(Banknote banknote, OwnBanknote oldOwnBanknote, OwnBanknote newOwnBanknote) async {
    // TODO: change status in DB
    final List<OwnBanknote> ownBanknotes = banknote.ownBanknotes;

    ownBanknotes.insert(ownBanknotes.indexOf(newOwnBanknote), ownBanknotes.removeAt(ownBanknotes.indexOf(oldOwnBanknote)));
    return ownBanknotes;
  }

  Future changeFavouriteStatus(Catalog country) async {
    // TODO: change status in DB
    country.isFavourite = !country.isFavourite;
  }

  Future addOwnBanknote(Banknote banknote, OwnBanknote ownBanknote) async {
    // TODO: add own banknote to DB and remove random
    banknote.ownBanknotes.add(OwnBanknote(ownBanknote.quality, ownBanknote.price,
        ownBanknote.currency, ownBanknote.comment, ownBanknote.images, id: Random().nextInt(10000)));
  }

  Future changeOwnBanknote(Banknote banknote, OwnBanknote ownBanknote) async {
    // TODO: change own to DB
    banknote.ownBanknotes[banknote.ownBanknotes.indexOf(ownBanknote)] = ownBanknote;
  }
}
