import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/image.dart';
import 'package:banknotes/data/model/many_to_many.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'own_banknote.jorm.dart';

class OwnBanknoteEntity {

  OwnBanknoteEntity();
  OwnBanknoteEntity.make(this.banknoteId, this.quality, this.price, this.currency,
      this.comment, this.images, this.date);

  @PrimaryKey(auto: true)
  int id;

  @BelongsTo(BanknoteBean)
  int banknoteId;

  @Column()
  double price;

  @Column()
  String currency;

  @Column()
  String quality;

  @Column()
  String comment;

  @ManyToMany(OwnBanknotesImageBean, ImageBean)
  List<ImageEntity> images;

  @Column()
  DateTime date;
}

@GenBean()
class OwnBanknoteBean extends Bean<OwnBanknoteEntity> with _OwnBanknoteBean {
  OwnBanknoteBean(Adapter adapter) : super(adapter);

  BanknoteBean _banknoteBean;
  ImageBean _imageBean;
  OwnBanknotesImageBean _ownBanknotesImageBean;

  @override
  BanknoteBean get banknoteEntityBean => _banknoteBean ??= BanknoteBean(adapter);

  @override
  ImageBean get imageEntityBean => _imageBean ??= ImageBean(adapter);

  @override
  OwnBanknotesImageBean get ownBanknotesImageEntityBean => _ownBanknotesImageBean ??= OwnBanknotesImageBean(adapter);

  @override
  String get tableName => 'OwnBanknote';


}