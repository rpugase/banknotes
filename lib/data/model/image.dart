import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/many_to_many.dart';
import 'package:banknotes/data/model/own_banknote.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'image.jorm.dart';

class ImageEntity {
  ImageEntity();
  ImageEntity.make(this.path, this.main);

  @PrimaryKey(auto: true)
  int id;

  @Column()
  String path;

  @Column()
  bool main;

  @ManyToMany(BanknotesImageBean, BanknoteBean)
  List<BanknoteEntity> banknotes;

  @ManyToMany(OwnBanknotesImageBean, OwnBanknoteBean)
  List<OwnBanknoteEntity> ownBanknotes;
}

@GenBean()
class ImageBean extends Bean<ImageEntity> with _ImageBean {
  ImageBean(Adapter adapter) : super(adapter);

  OwnBanknoteBean _ownBanknoteBean;
  BanknoteBean _banknoteBean;
  BanknotesImageBean _banknotesImageBean;
  OwnBanknotesImageBean _ownBanknotesImageBean;

  @override
  BanknoteBean get banknoteEntityBean => _banknoteBean ??= BanknoteBean(adapter);

  @override
  BanknotesImageBean get banknotesImageEntityBean => _banknotesImageBean ??= BanknotesImageBean(adapter);

  @override
  OwnBanknoteBean get ownBanknoteEntityBean => _ownBanknoteBean ??= OwnBanknoteBean(adapter);

  @override
  OwnBanknotesImageBean get ownBanknotesImageEntityBean => _ownBanknotesImageBean ??= OwnBanknotesImageBean(adapter);

  @override
  String get tableName => 'Image';
}