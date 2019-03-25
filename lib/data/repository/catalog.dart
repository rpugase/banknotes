import 'package:banknotes/data/model/catalog.dart';

abstract class CatalogRepository {
  Future<List<CatalogEntity>> getAllCatalogs();
  Future<List<CatalogEntity>> replaceCatalogsPositions(int oldCatalogId, int newCatalogId);
}

class CatalogDbRepository implements CatalogRepository {
  CatalogDbRepository(this.catalogBean);
  final CatalogBean catalogBean;

  @override
  Future<List<CatalogEntity>> getAllCatalogs() async => throw UnimplementedError();

  @override
  Future<List<CatalogEntity>> replaceCatalogsPositions(int oldCatalogId, int newCatalogId)
  async => throw UnimplementedError();
}

class CatalogMockRepository implements CatalogRepository {
  List<CatalogEntity> get _catalogs => [
    CatalogEntity.make("Ukraine", 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-ukraine_1f1fa-1f1e6.png', true, [])..id = 0..position = 1,
    CatalogEntity.make("Russian", 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-russia_1f1f7-1f1fa.png', true, [])..id = 1..position = 2,
    CatalogEntity.make("USA", 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-united-states_1f1fa-1f1f8.png', true, [])..id = 2..position = 3,
    CatalogEntity.make("Poland", 'https://img2.freepng.ru/20180607/ofv/kisspng-flag-of-poland-national-flag-flag-of-luxembourg-5b18cf4603a445.2491190015283525820149.jpg', false, [])..id = 3..position = 4,
    CatalogEntity.make("France", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_TQQbozGXawLCJtaozI4WNNzxF2QIfQ0_82o3N5NHNZu0fal8jQ', false, [])..id = 4..position = 5,
  ];

  @override
  Future<List<CatalogEntity>> getAllCatalogs() async {
    await Future.delayed(Duration(seconds: 1));

    return _catalogs;
  }

  @override
  Future<List<CatalogEntity>> replaceCatalogsPositions(int oldCatalogId, int newCatalogId) async {
    return await Future.delayed(Duration(seconds: 1));
  }
}
