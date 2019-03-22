// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _CatalogBean implements Bean<CatalogEntity> {
  final id = IntField('id');
  final name = StrField('name');
  final image = StrField('image');
  final isFavourite = BoolField('is_favourite');
  final position = IntField('position');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        name.name: name,
        image.name: image,
        isFavourite.name: isFavourite,
        position.name: position,
      };
  CatalogEntity fromMap(Map map) {
    CatalogEntity model = CatalogEntity();
    model.id = adapter.parseValue(map['id']);
    model.name = adapter.parseValue(map['name']);
    model.image = adapter.parseValue(map['image']);
    model.isFavourite = adapter.parseValue(map['is_favourite']);
    model.position = adapter.parseValue(map['position']);

    return model;
  }

  List<SetColumn> toSetColumns(CatalogEntity model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(name.set(model.name));
      ret.add(image.set(model.image));
      ret.add(isFavourite.set(model.isFavourite));
      ret.add(position.set(model.position));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(name.name)) ret.add(name.set(model.name));
      if (only.contains(image.name)) ret.add(image.set(model.image));
      if (only.contains(isFavourite.name))
        ret.add(isFavourite.set(model.isFavourite));
      if (only.contains(position.name)) ret.add(position.set(model.position));
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists: false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(name.name, isNullable: false);
    st.addStr(image.name, isNullable: false);
    st.addBool(isFavourite.name, isNullable: false);
    st.addInt(position.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(CatalogEntity model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
    if (cascade) {
      CatalogEntity newModel;
      if (model.modifications != null) {
        newModel ??= await find(model.id);
        model.modifications.forEach(
            (x) => emissionEntityBean.associateCatalogEntity(x, newModel));
        for (final child in model.modifications) {
          await emissionEntityBean.insert(child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<CatalogEntity> models,
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

  Future<dynamic> upsert(CatalogEntity model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      CatalogEntity newModel;
      if (model.modifications != null) {
        newModel ??= await find(model.id);
        model.modifications.forEach(
            (x) => emissionEntityBean.associateCatalogEntity(x, newModel));
        for (final child in model.modifications) {
          await emissionEntityBean.upsert(child);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<CatalogEntity> models,
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

  Future<int> update(CatalogEntity model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      CatalogEntity newModel;
      if (model.modifications != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.modifications.forEach(
              (x) => emissionEntityBean.associateCatalogEntity(x, newModel));
        }
        for (final child in model.modifications) {
          await emissionEntityBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<CatalogEntity> models,
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

  Future<CatalogEntity> find(int id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final CatalogEntity model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final CatalogEntity newModel = await find(id);
      if (newModel != null) {
        await emissionEntityBean.removeByCatalogEntity(newModel.id);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<CatalogEntity> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<CatalogEntity> preload(CatalogEntity model,
      {bool cascade: false}) async {
    model.modifications = await emissionEntityBean.findByCatalogEntity(model.id,
        preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<CatalogEntity>> preloadAll(List<CatalogEntity> models,
      {bool cascade: false}) async {
    models.forEach((CatalogEntity model) => model.modifications ??= []);
    await OneToXHelper.preloadAll<CatalogEntity, EmissionEntity>(
        models,
        (CatalogEntity model) => [model.id],
        emissionEntityBean.findByCatalogEntityList,
        (EmissionEntity model) => [model.catalogId],
        (CatalogEntity model, EmissionEntity child) =>
            model.modifications.add(child),
        cascade: cascade);
    return models;
  }

  EmissionBean get emissionEntityBean;
}
