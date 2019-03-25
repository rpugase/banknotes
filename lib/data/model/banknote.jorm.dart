// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banknote.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _BanknoteBean implements Bean<BanknoteEntity> {
  final id = IntField('id');
  final emissionId = IntField('emission_id');
  final name = StrField('name');
  final description = StrField('description');
  final year = StrField('year');
  final printer = StrField('printer');
  final entryDate = StrField('entry_date');
  final parentId = IntField('parent_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        emissionId.name: emissionId,
        name.name: name,
        description.name: description,
        year.name: year,
        printer.name: printer,
        entryDate.name: entryDate,
        parentId.name: parentId,
      };
  BanknoteEntity fromMap(Map map) {
    BanknoteEntity model = BanknoteEntity();
    model.id = adapter.parseValue(map['id']);
    model.emissionId = adapter.parseValue(map['emission_id']);
    model.name = adapter.parseValue(map['name']);
    model.description = adapter.parseValue(map['description']);
    model.year = adapter.parseValue(map['year']);
    model.printer = adapter.parseValue(map['printer']);
    model.entryDate = adapter.parseValue(map['entry_date']);
    model.parentId = adapter.parseValue(map['parent_id']);

    return model;
  }

  List<SetColumn> toSetColumns(BanknoteEntity model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(emissionId.set(model.emissionId));
      ret.add(name.set(model.name));
      ret.add(description.set(model.description));
      ret.add(year.set(model.year));
      ret.add(printer.set(model.printer));
      ret.add(entryDate.set(model.entryDate));
      ret.add(parentId.set(model.parentId));
    } else {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(emissionId.name))
        ret.add(emissionId.set(model.emissionId));
      if (only.contains(name.name)) ret.add(name.set(model.name));
      if (only.contains(description.name))
        ret.add(description.set(model.description));
      if (only.contains(year.name)) ret.add(year.set(model.year));
      if (only.contains(printer.name)) ret.add(printer.set(model.printer));
      if (only.contains(entryDate.name))
        ret.add(entryDate.set(model.entryDate));
      if (only.contains(parentId.name)) ret.add(parentId.set(model.parentId));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addInt(emissionId.name,
        foreignTable: emissionEntityBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    st.addStr(name.name, isNullable: false);
    st.addStr(description.name, isNullable: false);
    st.addStr(year.name, length: 4, isNullable: false);
    st.addStr(printer.name, isNullable: false);
    st.addStr(entryDate.name, isNullable: false);
    st.addInt(parentId.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(BanknoteEntity model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model)).id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      BanknoteEntity newModel;
      if (model.images != null) {
        newModel ??= await find(retId);
        for (final child in model.images) {
          await imageEntityBean.insert(child);
          await banknotesImageEntityBean.attach(child, model);
        }
      }
      if (model.ownBanknotes != null) {
        newModel ??= await find(retId);
        model.ownBanknotes.forEach(
            (x) => ownBanknoteEntityBean.associateBanknoteEntity(x, newModel));
        for (final child in model.ownBanknotes) {
          await ownBanknoteEntityBean.insert(child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<BanknoteEntity> models,
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

  Future<dynamic> upsert(BanknoteEntity model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model)).id(id.name);
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      BanknoteEntity newModel;
      if (model.images != null) {
        newModel ??= await find(retId);
        for (final child in model.images) {
          await imageEntityBean.upsert(child);
          await banknotesImageEntityBean.attach(child, model);
        }
      }
      if (model.ownBanknotes != null) {
        newModel ??= await find(retId);
        model.ownBanknotes.forEach(
            (x) => ownBanknoteEntityBean.associateBanknoteEntity(x, newModel));
        for (final child in model.ownBanknotes) {
          await ownBanknoteEntityBean.upsert(child);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<BanknoteEntity> models,
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

  Future<int> update(BanknoteEntity model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      BanknoteEntity newModel;
      if (model.images != null) {
        for (final child in model.images) {
          await imageEntityBean.update(child);
        }
      }
      if (model.ownBanknotes != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.ownBanknotes.forEach((x) =>
              ownBanknoteEntityBean.associateBanknoteEntity(x, newModel));
        }
        for (final child in model.ownBanknotes) {
          await ownBanknoteEntityBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<BanknoteEntity> models,
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

  Future<BanknoteEntity> find(int id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final BanknoteEntity model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final BanknoteEntity newModel = await find(id);
      if (newModel != null) {
        await banknotesImageEntityBean.detachBanknoteEntity(newModel);
        await ownBanknoteEntityBean.removeByBanknoteEntity(newModel.id);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<BanknoteEntity> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<List<BanknoteEntity>> findByEmissionEntity(int emissionId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.emissionId.eq(emissionId));
    final List<BanknoteEntity> models = await findMany(find);
    if (preload) {
      await this.preloadAll(models, cascade: cascade);
    }
    return models;
  }

  Future<List<BanknoteEntity>> findByEmissionEntityList(
      List<EmissionEntity> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (EmissionEntity model in models) {
      find.or(this.emissionId.eq(model.id));
    }
    final List<BanknoteEntity> retModels = await findMany(find);
    if (preload) {
      await this.preloadAll(retModels, cascade: cascade);
    }
    return retModels;
  }

  Future<int> removeByEmissionEntity(int emissionId) async {
    final Remove rm = remover.where(this.emissionId.eq(emissionId));
    return await adapter.remove(rm);
  }

  void associateEmissionEntity(BanknoteEntity child, EmissionEntity parent) {
    child.emissionId = parent.id;
  }

  Future<BanknoteEntity> preload(BanknoteEntity model,
      {bool cascade: false}) async {
    model.images = await banknotesImageEntityBean.fetchByBanknoteEntity(model);
    model.ownBanknotes = await ownBanknoteEntityBean
        .findByBanknoteEntity(model.id, preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<BanknoteEntity>> preloadAll(List<BanknoteEntity> models,
      {bool cascade: false}) async {
    for (BanknoteEntity model in models) {
      var temp = await banknotesImageEntityBean.fetchByBanknoteEntity(model);
      if (model.images == null)
        model.images = temp;
      else {
        model.images.clear();
        model.images.addAll(temp);
      }
    }
    models.forEach((BanknoteEntity model) => model.ownBanknotes ??= []);
    await OneToXHelper.preloadAll<BanknoteEntity, OwnBanknoteEntity>(
        models,
        (BanknoteEntity model) => [model.id],
        ownBanknoteEntityBean.findByBanknoteEntityList,
        (OwnBanknoteEntity model) => [model.banknoteId],
        (BanknoteEntity model, OwnBanknoteEntity child) =>
            model.ownBanknotes.add(child),
        cascade: cascade);
    return models;
  }

  BanknotesImageBean get banknotesImageEntityBean;

  ImageBean get imageEntityBean;
  OwnBanknoteBean get ownBanknoteEntityBean;
  EmissionBean get emissionEntityBean;
}
