import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/image.dart';

abstract class CatalogRepository {
  Future<List<Catalog>> getFavouriteCatalogs();
}

class CatalogDbRepository implements CatalogRepository {
  @override
  Future<List<Catalog>> getFavouriteCatalogs() async => throw UnimplementedError();
}

class CatalogMockRepository implements CatalogRepository {
  @override
  Future<List<Catalog>> getFavouriteCatalogs() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Catalog(0, "Ukraine", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-ukraine_1f1fa-1f1e6.png', ImageType.network)),
      Catalog(1, "Russian", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-russia_1f1f7-1f1fa.png', ImageType.network)),
      Catalog(2, "USA", Image('https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/emojione/178/flag-for-united-states_1f1fa-1f1f8.png', ImageType.network)),
    ];
  }
}
