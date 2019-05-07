import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/catalog.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'emission.jorm.dart';

class EmissionEntity {
  EmissionEntity();
  EmissionEntity.make(this.catalogId, this.shortName, this.banknotes);

  @PrimaryKey(auto: true)
  int id;

  @BelongsTo(CatalogBean)
  int catalogId;

  @Column()
  String shortName;

  @HasMany(BanknoteBean)
  List<BanknoteEntity> banknotes;

  EmissionEntity.fromJson(dynamic emissionJson, catalogId) :
        id = emissionJson['id'],
        shortName = emissionJson['shortName'],
        this.catalogId = catalogId,
        banknotes = (emissionJson['banknotes'] as List<dynamic>).map((field) => BanknoteEntity.fromJson(field, emissionJson['id'])).toList();
}

@GenBean()
class EmissionBean extends Bean<EmissionEntity> with _EmissionBean {
  EmissionBean(Adapter adapter) : super(adapter);

  CatalogBean _catalogBean;
  BanknoteBean _banknoteBean;

  @override
  CatalogBean get catalogEntityBean => _catalogBean ??= CatalogBean(adapter);

  @override
  BanknoteBean get banknoteEntityBean => _banknoteBean ??= BanknoteBean(adapter);

  @override
  String get tableName => 'Emission';
}