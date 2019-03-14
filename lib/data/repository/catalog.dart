import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/modification.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

abstract class CatalogRepository {
  Future<List<Catalog>> getFavouriteCatalogs();
}

class CatalogDbRepository implements CatalogRepository {
  @override
  Future<List<Catalog>> getFavouriteCatalogs() async => throw UnimplementedError();
}

class CatalogMockRepository implements CatalogRepository {
  List<Modification> modifications;

  CatalogMockRepository() {

    List<Banknote> banknotes = [
      Banknote(0, "1 uah", "desc", ownBanknotes: []),
      Banknote(1, "2 uah", "desc", ownBanknotes: [OwnBanknote(0, QualityType.good, price: 12.5, currency: Currency(), date: DateTime.now())]),
      Banknote(2, "5 uah", "desc", ownBanknotes: []),
      Banknote(3, "10 uah", "desc", ownBanknotes: []),
      Banknote(4, "20 uah", "desc", ownBanknotes: []),
      Banknote(5, "50 uah", "desc", ownBanknotes: []),
      Banknote(6, "100 uah", "desc", ownBanknotes: []),
      Banknote(7, "500 uah", "desc", ownBanknotes: []),
    ];

    modifications = [
      Modification(0, "1994", banknotes)
    ];
  }

  @override
  Future<List<Catalog>> getFavouriteCatalogs() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Catalog(0, "Ukraine", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-ukraine_1f1fa-1f1e6.png', ImageType.network), modifications),
      Catalog(1, "Russian", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-russia_1f1f7-1f1fa.png', ImageType.network), modifications),
      Catalog(2, "USA", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-united-states_1f1fa-1f1f8.png', ImageType.network), modifications),
    ];
  }
}
