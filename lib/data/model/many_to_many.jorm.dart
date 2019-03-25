// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'many_to_many.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _BanknotesImageBean implements Bean<BanknotesImageEntity> {
  final banknotesId = IntField('banknotes_id');
  final imageId = IntField('image_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        banknotesId.name: banknotesId,
        imageId.name: imageId,
      };
  BanknotesImageEntity fromMap(Map map) {
    BanknotesImageEntity model = BanknotesImageEntity();
    model.banknotesId = adapter.parseValue(map['banknotes_id']);
    model.imageId = adapter.parseValue(map['image_id']);

    return model;
  }

  List<SetColumn> toSetColumns(BanknotesImageEntity model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(banknotesId.set(model.banknotesId));
      ret.add(imageId.set(model.imageId));
    } else {
      if (only.contains(banknotesId.name))
        ret.add(banknotesId.set(model.banknotesId));
      if (only.contains(imageId.name)) ret.add(imageId.set(model.imageId));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(banknotesId.name,
        foreignTable: banknoteEntityBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    st.addInt(imageId.name,
        foreignTable: imageEntityBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(BanknotesImageEntity model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<BanknotesImageEntity> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(BanknotesImageEntity model) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<BanknotesImageEntity> models) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<void> updateMany(List<BanknotesImageEntity> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<List<BanknotesImageEntity>> findByBanknoteEntity(int banknotesId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.banknotesId.eq(banknotesId));
    return findMany(find);
  }

  Future<List<BanknotesImageEntity>> findByBanknoteEntityList(
      List<BanknoteEntity> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (BanknoteEntity model in models) {
      find.or(this.banknotesId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByBanknoteEntity(int banknotesId) async {
    final Remove rm = remover.where(this.banknotesId.eq(banknotesId));
    return await adapter.remove(rm);
  }

  void associateBanknoteEntity(
      BanknotesImageEntity child, BanknoteEntity parent) {
    child.banknotesId = parent.id;
  }

  Future<int> detachBanknoteEntity(BanknoteEntity model) async {
    final dels = await findByBanknoteEntity(model.id);
    await removeByBanknoteEntity(model.id);
    final exp = Or();
    for (final t in dels) {
      exp.or(imageEntityBean.id.eq(t.imageId));
    }
    return await imageEntityBean.removeWhere(exp);
  }

  Future<List<ImageEntity>> fetchByBanknoteEntity(BanknoteEntity model) async {
    final pivots = await findByBanknoteEntity(model.id);
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(imageEntityBean.id.eq(t.imageId));
    }
    return await imageEntityBean.findWhere(exp);
  }

  Future<List<BanknotesImageEntity>> findByImageEntity(int imageId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.imageId.eq(imageId));
    return findMany(find);
  }

  Future<List<BanknotesImageEntity>> findByImageEntityList(
      List<ImageEntity> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (ImageEntity model in models) {
      find.or(this.imageId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByImageEntity(int imageId) async {
    final Remove rm = remover.where(this.imageId.eq(imageId));
    return await adapter.remove(rm);
  }

  void associateImageEntity(BanknotesImageEntity child, ImageEntity parent) {
    child.imageId = parent.id;
  }

  Future<int> detachImageEntity(ImageEntity model) async {
    final dels = await findByImageEntity(model.id);
    await removeByImageEntity(model.id);
    final exp = Or();
    for (final t in dels) {
      exp.or(banknoteEntityBean.id.eq(t.banknotesId));
    }
    return await banknoteEntityBean.removeWhere(exp);
  }

  Future<List<BanknoteEntity>> fetchByImageEntity(ImageEntity model) async {
    final pivots = await findByImageEntity(model.id);
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(banknoteEntityBean.id.eq(t.banknotesId));
    }
    return await banknoteEntityBean.findWhere(exp);
  }

  Future<dynamic> attach(ImageEntity one, BanknoteEntity two) async {
    final ret = BanknotesImageEntity();
    ret.imageId = one.id;
    ret.banknotesId = two.id;
    return insert(ret);
  }

  BanknoteBean get banknoteEntityBean;
  ImageBean get imageEntityBean;
}

abstract class _OwnBanknotesImageBean implements Bean<OwnBanknotesImageEntity> {
  final ownBanknotesId = IntField('own_banknotes_id');
  final imageId = IntField('image_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        ownBanknotesId.name: ownBanknotesId,
        imageId.name: imageId,
      };
  OwnBanknotesImageEntity fromMap(Map map) {
    OwnBanknotesImageEntity model = OwnBanknotesImageEntity();
    model.ownBanknotesId = adapter.parseValue(map['own_banknotes_id']);
    model.imageId = adapter.parseValue(map['image_id']);

    return model;
  }

  List<SetColumn> toSetColumns(OwnBanknotesImageEntity model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(ownBanknotesId.set(model.ownBanknotesId));
      ret.add(imageId.set(model.imageId));
    } else {
      if (only.contains(ownBanknotesId.name))
        ret.add(ownBanknotesId.set(model.ownBanknotesId));
      if (only.contains(imageId.name)) ret.add(imageId.set(model.imageId));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(ownBanknotesId.name,
        foreignTable: ownBanknoteEntityBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    st.addInt(imageId.name,
        foreignTable: imageEntityBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(OwnBanknotesImageEntity model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<OwnBanknotesImageEntity> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(OwnBanknotesImageEntity model) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<OwnBanknotesImageEntity> models) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<void> updateMany(List<OwnBanknotesImageEntity> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<List<OwnBanknotesImageEntity>> findByOwnBanknoteEntity(
      int ownBanknotesId,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder.where(this.ownBanknotesId.eq(ownBanknotesId));
    return findMany(find);
  }

  Future<List<OwnBanknotesImageEntity>> findByOwnBanknoteEntityList(
      List<OwnBanknoteEntity> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (OwnBanknoteEntity model in models) {
      find.or(this.ownBanknotesId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByOwnBanknoteEntity(int ownBanknotesId) async {
    final Remove rm = remover.where(this.ownBanknotesId.eq(ownBanknotesId));
    return await adapter.remove(rm);
  }

  void associateOwnBanknoteEntity(
      OwnBanknotesImageEntity child, OwnBanknoteEntity parent) {
    child.ownBanknotesId = parent.id;
  }

  Future<int> detachOwnBanknoteEntity(OwnBanknoteEntity model) async {
    final dels = await findByOwnBanknoteEntity(model.id);
    await removeByOwnBanknoteEntity(model.id);
    final exp = Or();
    for (final t in dels) {
      exp.or(imageEntityBean.id.eq(t.imageId));
    }
    return await imageEntityBean.removeWhere(exp);
  }

  Future<List<ImageEntity>> fetchByOwnBanknoteEntity(
      OwnBanknoteEntity model) async {
    final pivots = await findByOwnBanknoteEntity(model.id);
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(imageEntityBean.id.eq(t.imageId));
    }
    return await imageEntityBean.findWhere(exp);
  }

  Future<List<OwnBanknotesImageEntity>> findByImageEntity(int imageId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.imageId.eq(imageId));
    return findMany(find);
  }

  Future<List<OwnBanknotesImageEntity>> findByImageEntityList(
      List<ImageEntity> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (ImageEntity model in models) {
      find.or(this.imageId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByImageEntity(int imageId) async {
    final Remove rm = remover.where(this.imageId.eq(imageId));
    return await adapter.remove(rm);
  }

  void associateImageEntity(OwnBanknotesImageEntity child, ImageEntity parent) {
    child.imageId = parent.id;
  }

  Future<int> detachImageEntity(ImageEntity model) async {
    final dels = await findByImageEntity(model.id);
    await removeByImageEntity(model.id);
    final exp = Or();
    for (final t in dels) {
      exp.or(ownBanknoteEntityBean.id.eq(t.ownBanknotesId));
    }
    return await ownBanknoteEntityBean.removeWhere(exp);
  }

  Future<List<OwnBanknoteEntity>> fetchByImageEntity(ImageEntity model) async {
    final pivots = await findByImageEntity(model.id);
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(ownBanknoteEntityBean.id.eq(t.ownBanknotesId));
    }
    return await ownBanknoteEntityBean.findWhere(exp);
  }

  Future<dynamic> attach(OwnBanknoteEntity one, ImageEntity two) async {
    final ret = OwnBanknotesImageEntity();
    ret.ownBanknotesId = one.id;
    ret.imageId = two.id;
    return insert(ret);
  }

  OwnBanknoteBean get ownBanknoteEntityBean;
  ImageBean get imageEntityBean;
}
