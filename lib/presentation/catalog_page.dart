import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/presentation/emission_page.dart';
import 'package:banknotes/presentation/full_catalog_page.dart';
import 'package:banknotes/presentation/widget/reordeble_list.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:banknotes/util/utils_functions.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  final DataManager _dataManager = Injector().dataManager;
  bool _isLoading = true;
  List<Catalog> _catalogs = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).countries),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.add),
            onPressed: _openFullCatalogPage,
          ),
        ],
      ),
      body: Container(
        child : (_isLoading) ? _buildLoading()
            : (_catalogs.isEmpty) ? _buildEmpty() 
            : _buildContent(_catalogs),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        Localization.of(context).noData,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _buildContent(List<Catalog> catalogs) {
    return ReorderableList(
      onReorder: _reorderCallback,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => CustomReorderableItem(
              key: Key(_catalogs[index].id.toString()),
              isFirst: index == 0,
              isLast: index == _catalogs.length - 1,
              onItemCreate: (context) => _buildCategoryTile(_catalogs[index]),
            ), childCount: _catalogs.length),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryTile(Catalog catalog) {
    return ListTile(
      key: Key(catalog.id.toString()),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        catalog.image.path,
        width: 48.0,
        height: 48.0,
      ),
      title: Text(catalog.name),
      trailing: Icon(Icons.menu),
      onTap: () => _openModificationPage(catalog),
    );
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int _getIndexByKey(Key key) => _catalogs.indexWhere((catalog) => Key(catalog.id.toString()) == key);

    int draggingIndex = _getIndexByKey(item);
    int newPositionIndex = _getIndexByKey(newPosition);

    _dataManager.replaceCatalogsPositions(_catalogs[draggingIndex], _catalogs[newPositionIndex])
        .then((catalogs) => setState(() => _catalogs = catalogs),
        onError: (error) => showError(context, error, _onError));
    return true;
  }

  void _loadData() {
    _dataManager.getFavouriteCatalogs().then((catalogs) {
      setState(() {
        _catalogs = catalogs;
        _isLoading = false;
      });
    }, onError: (error) => showError(context, error, _onError));
  }

  void _onError() {
    setState(() {
      _isLoading = false;
    });
  }

  void _openFullCatalogPage() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullCatalogPage()));

    _loadData();
  }

  void _openModificationPage(Catalog catalog) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmissionPage(catalog)));
  }
}