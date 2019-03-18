import 'package:banknotes/domain/catalog.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/presentation/full_catalog/page.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  CatalogRepository _repository = Injector().catalogRepository;
  bool _isLoading = true;
  List<Catalog> _catalogs = [];
  
  @override
  void initState() {
    _loadData();
    super.initState();
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
    return Scrollbar(
      child: ReorderableListView(
        children: _divideTiles(
          color: Colors.grey,
          tiles: catalogs.map(_buildCategoryTile).toList(),
        ).toList(),
        onReorder: _replaceCatalogsPositions,
      ),
    );
  }

  Widget _buildCategoryTile(Catalog catalog) {
    return ListTile(
      key: Key(catalog.id.toString()),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        catalog.image.path,
        width: 48.0,
        height: 48.0,
      ),
      title: Text(catalog.name),
      trailing: Icon(Icons.menu),
    );
  }

  void _loadData() {
    _repository.getFavouriteCatalogs().then((catalogs) {
      setState(() {
        _catalogs = catalogs;
        _isLoading = false;
      });
    });
  }

  void _replaceCatalogsPositions(int oldIndex, int newIndex) {
    _repository.replaceCatalogsPositions(_catalogs[oldIndex], _catalogs[newIndex]).then((catalogs) => {
      setState(() {
        _catalogs = catalogs;
      })
    }, onError: (error) => print(error.toString()));
  }

  void _openFullCatalogPage() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullCatalogPage()));

//    _loadData();
  }

  Iterable<Widget> _divideTiles({@required Iterable<Widget> tiles, Color color}) sync* {
    assert(tiles != null);
    assert(color != null || context != null);

    final Iterator<Widget> iterator = tiles.iterator;
    final bool isNotEmpty = iterator.moveNext();

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context, color: color),
      ),
    );

    Widget tile = iterator.current;
    while (iterator.moveNext()) {
      yield DecoratedBox(
        key: UniqueKey(),
        position: DecorationPosition.foreground,
        decoration: decoration,
        child: tile,
      );
      tile = iterator.current;
    }
    if (isNotEmpty) yield tile;
  }
}