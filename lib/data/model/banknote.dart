import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/data/model/image.dart';
import 'package:banknotes/data/model/many_to_many.dart';
import 'package:banknotes/data/model/own_banknote.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'banknote.jorm.dart';

class BanknoteEntity {
  BanknoteEntity();
  BanknoteEntity.make(this.emissionId, this.name, this.description, this.year, this.printer,
      this.entryDate, this.parentId, this.images, this.ownBanknotes);

  @PrimaryKey(auto: true)
  int id;

  @BelongsTo(EmissionBean)
  int emissionId;

  @Column()
  String name;

  @Column()
  String description;

  @Column(length: 4)
  String year;

  @Column()
  String printer;

  @Column()
  String entryDate;

  @Column()
  int parentId;

  @ManyToMany(BanknotesImageBean, ImageBean)
  List<ImageEntity> images;

  @HasMany(OwnBanknoteBean)
  List<OwnBanknoteEntity> ownBanknotes;
}

@GenBean()
class BanknoteBean extends Bean<BanknoteEntity> with _BanknoteBean {
  BanknoteBean(Adapter adapter) :
        super(adapter);

  EmissionBean _emissionBean;
  OwnBanknoteBean _ownBanknoteBean;
  BanknotesImageBean _banknotesImageBean;
  ImageBean _imageBean;

  @override
  EmissionBean get emissionEntityBean => _emissionBean ??= EmissionBean(adapter);

  @override
  OwnBanknoteBean get ownBanknoteEntityBean => _ownBanknoteBean ??= OwnBanknoteBean(adapter);

  @override
  BanknotesImageBean get banknotesImageEntityBean => _banknotesImageBean ??= BanknotesImageBean(adapter);

  @override
  ImageBean get imageEntityBean => _imageBean ??= ImageBean(adapter);

  @override
  String get tableName => 'Banknote';
}
