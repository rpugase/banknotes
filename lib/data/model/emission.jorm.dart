// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emission.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _EmissionBean implements Bean<EmissionEntity> {
  final id = IntField('id');
  final catalogId = IntField('catalog_id');
  final shortName = StrField('short_name');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        catalogId.name: catalogId,
        shortName.name: shortName,
      };
  EmissionEntity fromMap(Map map) {
    EmissionEntity model = EmissionEntity();
    model.id = adapter.parseValue(map['id']);
    model.catalogId = adapter.parseValue(map['catalog_id']);
    model.shortName = adapter.parseValue(map['short_name']);

    return model;
  }

  List<SetColumn> toSetColumns(EmissionEntity model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(catalogId.set(model.catalogId));
      ret.add(shortName.set(model.shortName));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(catalogId.name))
        ret.add(catalogId.set(model.catalogId));
      if (only.contains(shortName.name))
        ret.add(shortName.set(model.shortName));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addInt(catalogId.name,
        foreignTable: catalogEntityBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    st.addStr(shortName.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(EmissionEntity model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
    if (cascade) {
      EmissionEntity newModel;
      if (model.banknotes != null) {
        newModel ??= await find(model.id);
        model.banknotes.forEach(
            (x) => banknoteEntityBean.associateEmissionEntity(x, newModel));
        for (final child in model.banknotes) {
          await banknoteEntityBean.insert(child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<EmissionEntity> models,
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

  Future<dynamic> upsert(EmissionEntity model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      EmissionEntity newModel;
      if (model.banknotes != null) {
        newModel ??= await find(model.id);
        model.banknotes.forEach(
            (x) => banknoteEntityBean.associateEmissionEntity(x, newModel));
        for (final child in model.banknotes) {
          await banknoteEntityBean.upsert(child);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<EmissionEntity> models,
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

  Future<int> update(EmissionEntity model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      EmissionEntity newModel;
      if (model.banknotes != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.banknotes.forEach(
              (x) => banknoteEntityBean.associateEmissionEntity(x, newModel));
        }
        for (final child in model.banknotes) {
          await banknoteEntityBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<EmissionEntity> models,
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

  Future<EmissionEntity> find(int id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final EmissionEntity model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final EmissionEntity newModel = await find(id);
      if (newModel != null) {
        await banknoteEntityBean.removeByEmissionEntity(newModel.id);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<EmissionEntity> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<List<EmissionEntity>> findByCatalogEntity(int catalogId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.catalogId.eq(catalogId));
    final List<EmissionEntity> models = await findMany(find);
    if (preload) {
      await this.preloadAll(models, cascade: cascade);
    }
    return models;
  }

  Future<List<EmissionEntity>> findByCatalogEntityList(
      List<CatalogEntity> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (CatalogEntity model in models) {
      find.or(this.catalogId.eq(model.id));
    }
    final List<EmissionEntity> retModels = await findMany(find);
    if (preload) {
      await this.preloadAll(retModels, cascade: cascade);
    }
    return retModels;
  }

  Future<int> removeByCatalogEntity(int catalogId) async {
    final Remove rm = remover.where(this.catalogId.eq(catalogId));
    return await adapter.remove(rm);
  }

  void associateCatalogEntity(EmissionEntity child, CatalogEntity parent) {
    child.catalogId = parent.id;
  }

  Future<EmissionEntity> preload(EmissionEntity model,
      {bool cascade: false}) async {
    model.banknotes = await banknoteEntityBean.findByEmissionEntity(model.id,
        preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<EmissionEntity>> preloadAll(List<EmissionEntity> models,
      {bool cascade: false}) async {
    models.forEach((EmissionEntity model) => model.banknotes ??= []);
    await OneToXHelper.preloadAll<EmissionEntity, BanknoteEntity>(
        models,
        (EmissionEntity model) => [model.id],
        banknoteEntityBean.findByEmissionEntityList,
        (BanknoteEntity model) => [model.emissionId],
        (EmissionEntity model, BanknoteEntity child) =>
            model.banknotes.add(child),
        cascade: cascade);
    return models;
  }

  BanknoteBean get banknoteEntityBean;
  CatalogBean get catalogEntityBean;
}
