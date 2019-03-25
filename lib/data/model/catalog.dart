import 'package:banknotes/data/model/emission.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'catalog.jorm.dart';

class CatalogEntity {
  CatalogEntity();
  CatalogEntity.make(this.name, this.image, this.isFavourite, this.emissions);

  @PrimaryKey(auto: true)
  int id;

  @Column()
  String name;

  @Column()
  String image;

  @Column()
  bool isFavourite;

  @Column()
  int position;

  @HasMany(EmissionBean)
  List<EmissionEntity> emissions;
}

@GenBean()
class CatalogBean extends Bean<CatalogEntity> with _CatalogBean {
  CatalogBean(Adapter adapter) : super(adapter);

  EmissionBean _emissionBean;

  @override
  EmissionBean get emissionEntityBean => _emissionBean ??= EmissionBean(adapter);

  @override
  String get tableName => 'Catalog';
}