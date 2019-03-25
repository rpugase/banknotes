import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/image.dart';
import 'package:banknotes/data/model/own_banknote.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'many_to_many.jorm.dart';

class BanknotesImageEntity {

  BanknotesImageEntity();

  @BelongsTo.many(BanknoteBean)
  int banknotesId;

  @BelongsTo.many(ImageBean)
  int imageId;
}

class OwnBanknotesImageEntity {

  OwnBanknotesImageEntity();

  @BelongsTo.many(OwnBanknoteBean)
  int ownBanknotesId;

  @BelongsTo.many(ImageBean)
  int imageId;
}

@GenBean()
class BanknotesImageBean extends Bean<BanknotesImageEntity> with _BanknotesImageBean {
  BanknotesImageBean(Adapter adapter) : super(adapter);

  BanknoteBean _banknoteBean;
  ImageBean _imageBean;

  @override
  BanknoteBean get banknoteEntityBean => _banknoteBean ??= BanknoteBean(adapter);

  @override
  ImageBean get imageEntityBean => _imageBean ??= ImageBean(adapter);

  @override
  String get tableName => 'BanknotesImage';

}

@GenBean()
class OwnBanknotesImageBean extends Bean<OwnBanknotesImageEntity> with _OwnBanknotesImageBean {
  OwnBanknotesImageBean(Adapter adapter) : super(adapter);

  OwnBanknoteBean _banknoteBean;
  ImageBean _imageBean;
  
  @override
  ImageBean get imageEntityBean => _imageBean ??= ImageBean(adapter);

  @override
  OwnBanknoteBean get ownBanknoteEntityBean => _banknoteBean ??= OwnBanknoteBean(adapter);

  @override
  String get tableName => 'OwnBanknotesImage';

}