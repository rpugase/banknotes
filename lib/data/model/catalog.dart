import 'package:banknotes/data/model/emission.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'catalog.jorm.dart';

class CatalogEntity {
  CatalogEntity();
  CatalogEntity.make(this.name, this.image, this.isFavourite, this.position, this.modifications);

  @PrimaryKey()
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
  List<EmissionEntity> modifications;
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