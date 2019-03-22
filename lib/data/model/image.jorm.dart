// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ImageBean implements Bean<ImageEntity> {
  final id = IntField('id');
  final path = StrField('path');
  final main = BoolField('main');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        path.name: path,
        main.name: main,
      };
  ImageEntity fromMap(Map map) {
    ImageEntity model = ImageEntity();
    model.id = adapter.parseValue(map['id']);
    model.path = adapter.parseValue(map['path']);
    model.main = adapter.parseValue(map['main']);

    return model;
  }

  List<SetColumn> toSetColumns(ImageEntity model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(path.set(model.path));
      ret.add(main.set(model.main));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(path.name)) ret.add(path.set(model.path));
      if (only.contains(main.name)) ret.add(main.set(model.main));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(path.name, isNullable: false);
    st.addBool(main.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ImageEntity model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
    if (cascade) {
      ImageEntity newModel;
      if (model.banknotes != null) {
        newModel ??= await find(model.id);
        for (final child in model.banknotes) {
          await banknoteEntityBean.insert(child);
          await banknotesImageEntityBean.attach(model, child);
        }
      }
      if (model.ownBanknotes != null) {
        newModel ??= await find(model.id);
        for (final child in model.ownBanknotes) {
          await ownBanknoteEntityBean.insert(child);
          await ownBanknotesImageEntityBean.attach(child, model);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<ImageEntity> models,
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

  Future<dynamic> upsert(ImageEntity model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      ImageEntity newModel;
      if (model.banknotes != null) {
        newModel ??= await find(model.id);
        for (final child in model.banknotes) {
          await banknoteEntityBean.upsert(child);
          await banknotesImageEntityBean.attach(model, child);
        }
      }
      if (model.ownBanknotes != null) {
        newModel ??= await find(model.id);
        for (final child in model.ownBanknotes) {
          await ownBanknoteEntityBean.upsert(child);
          await ownBanknotesImageEntityBean.attach(child, model);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<ImageEntity> models,
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

  Future<int> update(ImageEntity model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      ImageEntity newModel;
      if (model.banknotes != null) {
        for (final child in model.banknotes) {
          await banknoteEntityBean.update(child);
        }
      }
      if (model.ownBanknotes != null) {
        for (final child in model.ownBanknotes) {
          await ownBanknoteEntityBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<ImageEntity> models,
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

  Future<ImageEntity> find(int id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final ImageEntity model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final ImageEntity newModel = await find(id);
      if (newModel != null) {
        await banknotesImageEntityBean.detachImageEntity(newModel);
        await ownBanknotesImageEntityBean.detachImageEntity(newModel);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<ImageEntity> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<ImageEntity> preload(ImageEntity model, {bool cascade: false}) async {
    model.banknotes = await banknotesImageEntityBean.fetchByImageEntity(model);
    model.ownBanknotes =
        await ownBanknotesImageEntityBean.fetchByImageEntity(model);
    return model;
  }

  Future<List<ImageEntity>> preloadAll(List<ImageEntity> models,
      {bool cascade: false}) async {
    for (ImageEntity model in models) {
      var temp = await banknotesImageEntityBean.fetchByImageEntity(model);
      if (model.banknotes == null)
        model.banknotes = temp;
      else {
        model.banknotes.clear();
        model.banknotes.addAll(temp);
      }
    }
    for (ImageEntity model in models) {
      var temp = await ownBanknotesImageEntityBean.fetchByImageEntity(model);
      if (model.ownBanknotes == null)
        model.ownBanknotes = temp;
      else {
        model.ownBanknotes.clear();
        model.ownBanknotes.addAll(temp);
      }
    }
    return models;
  }

  BanknotesImageBean get banknotesImageEntityBean;

  BanknoteBean get banknoteEntityBean;
  OwnBanknotesImageBean get ownBanknotesImageEntityBean;

  OwnBanknoteBean get ownBanknoteEntityBean;
}
