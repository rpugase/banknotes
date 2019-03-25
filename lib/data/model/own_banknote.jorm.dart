// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'own_banknote.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _OwnBanknoteBean implements Bean<OwnBanknoteEntity> {
  final id = IntField('id');
  final banknoteId = IntField('banknote_id');
  final price = DoubleField('price');
  final currency = StrField('currency');
  final quality = StrField('quality');
  final comment = StrField('comment');
  final date = DateTimeField('date');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        banknoteId.name: banknoteId,
        price.name: price,
        currency.name: currency,
        quality.name: quality,
        comment.name: comment,
        date.name: date,
      };
  OwnBanknoteEntity fromMap(Map map) {
    OwnBanknoteEntity model = OwnBanknoteEntity();
    model.id = adapter.parseValue(map['id']);
    model.banknoteId = adapter.parseValue(map['banknote_id']);
    model.price = adapter.parseValue(map['price']);
    model.currency = adapter.parseValue(map['currency']);
    model.quality = adapter.parseValue(map['quality']);
    model.comment = adapter.parseValue(map['comment']);
    model.date = adapter.parseValue(map['date']);

    return model;
  }

  List<SetColumn> toSetColumns(OwnBanknoteEntity model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(banknoteId.set(model.banknoteId));
      ret.add(price.set(model.price));
      ret.add(currency.set(model.currency));
      ret.add(quality.set(model.quality));
      ret.add(comment.set(model.comment));
      ret.add(date.set(model.date));
    } else {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(banknoteId.name))
        ret.add(banknoteId.set(model.banknoteId));
      if (only.contains(price.name)) ret.add(price.set(model.price));
      if (only.contains(currency.name)) ret.add(currency.set(model.currency));
      if (only.contains(quality.name)) ret.add(quality.set(model.quality));
      if (only.contains(comment.name)) ret.add(comment.set(model.comment));
      if (only.contains(date.name)) ret.add(date.set(model.date));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addInt(banknoteId.name,
        foreignTable: banknoteEntityBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    st.addDouble(price.name, isNullable: false);
    st.addStr(currency.name, isNullable: false);
    st.addStr(quality.name, isNullable: false);
    st.addStr(comment.name, isNullable: false);
    st.addDateTime(date.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(OwnBanknoteEntity model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model)).id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      OwnBanknoteEntity newModel;
      if (model.images != null) {
        newModel ??= await find(retId);
        for (final child in model.images) {
          await imageEntityBean.insert(child);
          await ownBanknotesImageEntityBean.attach(model, child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<OwnBanknoteEntity> models,
      {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<dynamic> upsert(OwnBanknoteEntity model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model)).id(id.name);
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      OwnBanknoteEntity newModel;
      if (model.images != null) {
        newModel ??= await find(retId);
        for (final child in model.images) {
          await imageEntityBean.upsert(child);
          await ownBanknotesImageEntityBean.attach(model, child);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<OwnBanknoteEntity> models,
      {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(upsert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
      }
      final UpsertMany upsert = upserters.addAll(data);
      await adapter.upsertMany(upsert);
      return;
    }
  }

  Future<int> update(OwnBanknoteEntity model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      OwnBanknoteEntity newModel;
      if (model.images != null) {
        for (final child in model.images) {
          await imageEntityBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<OwnBanknoteEntity> models,
      {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
        where.add(this.id.eq(model.id));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<OwnBanknoteEntity> find(int id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final OwnBanknoteEntity model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final OwnBanknoteEntity newModel = await find(id);
      if (newModel != null) {
        await ownBanknotesImageEntityBean.detachOwnBanknoteEntity(newModel);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<OwnBanknoteEntity> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<List<OwnBanknoteEntity>> findByBanknoteEntity(int banknoteId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.banknoteId.eq(banknoteId));
    final List<OwnBanknoteEntity> models = await findMany(find);
    if (preload) {
      await this.preloadAll(models, cascade: cascade);
    }
    return models;
  }

  Future<List<OwnBanknoteEntity>> findByBanknoteEntityList(
      List<BanknoteEntity> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (BanknoteEntity model in models) {
      find.or(this.banknoteId.eq(model.id));
    }
    final List<OwnBanknoteEntity> retModels = await findMany(find);
    if (preload) {
      await this.preloadAll(retModels, cascade: cascade);
    }
    return retModels;
  }

  Future<int> removeByBanknoteEntity(int banknoteId) async {
    final Remove rm = remover.where(this.banknoteId.eq(banknoteId));
    return await adapter.remove(rm);
  }

  void associateBanknoteEntity(OwnBanknoteEntity child, BanknoteEntity parent) {
    child.banknoteId = parent.id;
  }

  Future<OwnBanknoteEntity> preload(OwnBanknoteEntity model,
      {bool cascade: false}) async {
    model.images =
        await ownBanknotesImageEntityBean.fetchByOwnBanknoteEntity(model);
    return model;
  }

  Future<List<OwnBanknoteEntity>> preloadAll(List<OwnBanknoteEntity> models,
      {bool cascade: false}) async {
    for (OwnBanknoteEntity model in models) {
      var temp =
          await ownBanknotesImageEntityBean.fetchByOwnBanknoteEntity(model);
      if (model.images == null)
        model.images = temp;
      else {
        model.images.clear();
        model.images.addAll(temp);
      }
    }
    return models;
  }

  OwnBanknotesImageBean get ownBanknotesImageEntityBean;

  ImageBean get imageEntityBean;
  BanknoteBean get banknoteEntityBean;
}
