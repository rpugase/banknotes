import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/image.dart';

abstract class CatalogRepository {
  Future<List<Catalog>> getFavouriteCatalogs();
  Future<List<Catalog>> getAllCatalogs();
  Future<List<Catalog>> replaceCatalogsPositions(int oldCatalogId, int newCatalogId);
}

class CatalogDbRepository implements CatalogRepository {
  @override
  Future<List<Catalog>> getFavouriteCatalogs() async => throw UnimplementedError();

  @override
  Future<List<Catalog>> getAllCatalogs() async => throw UnimplementedError();

  @override
  Future<List<Catalog>> replaceCatalogsPositions(int oldCatalogId, int newCatalogId)
  async => throw UnimplementedError();
}

class CatalogMockRepository implements CatalogRepository {
  List<Catalog> get _catalogs => [
    Catalog(0, "Ukraine", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-ukraine_1f1fa-1f1e6.png', ImageType.network), isFavourite: true),
    Catalog(1, "Russian", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-russia_1f1f7-1f1fa.png', ImageType.network), isFavourite: true),
    Catalog(2, "USA", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-united-states_1f1fa-1f1f8.png', ImageType.network), isFavourite: true),
    Catalog(3, "Poland", Image('https://img2.freepng.ru/20180607/ofv/kisspng-flag-of-poland-national-flag-flag-of-luxembourg-5b18cf4603a445.2491190015283525820149.jpg', ImageType.network)),
    Catalog(4, "France", Image('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_TQQbozGXawLCJtaozI4WNNzxF2QIfQ0_82o3N5NHNZu0fal8jQ', ImageType.network)),
  ];

  @override
  Future<List<Catalog>> getFavouriteCatalogs() async {
    await Future.delayed(Duration(seconds: 1));

    return _catalogs.where((catalog) => catalog.isFavourite).toList();
  }

  @override
  Future<List<Catalog>> getAllCatalogs() async {
    await Future.delayed(Duration(seconds: 1));

    return _catalogs;
  }

  @override
  Future<List<Catalog>> replaceCatalogsPositions(int oldCatalogId, int newCatalogId) async {
    return await Future.delayed(Duration(seconds: 1));
  }
}
