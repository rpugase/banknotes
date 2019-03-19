import 'package:flutter/material.dart';
import 'package:banknotes/util/localization.dart';
import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/util/injector.dart';

class FullCatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullCatalogPageState();
}

class _FullCatalogPageState extends State<FullCatalogPage> {

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
        title: Text(Localization.of(context).catalogs),

      ),

      body: Container(
        child : (_isLoading) ? _buildLoading()
            : (_catalogs.isEmpty) ? _buildEmpty()
            : _buildContent(_catalogs),
      ),

    );
  }

  void _loadData() {
    _dataManager.getAllCatalogs().then((catalogs) {
      setState(() {
        _catalogs = catalogs;
        _isLoading = false;
      });
    });
  }


  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(List<Catalog> catalogs) {
    return ListView.separated(
      itemBuilder: (context, index) => _FullCatalogHolder(catalogs[index]),
      itemCount: catalogs.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
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
}

class _FullCatalogHolder extends StatefulWidget {
  _FullCatalogHolder(this._country);

  final Catalog _country;

  @override
  State<StatefulWidget> createState() {
    return MyWidgetState(_country);
  }
}

class MyWidgetState extends State<_FullCatalogHolder> {

  MyWidgetState(this._country);

  final Catalog _country;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _country.isFavourite,
      onChanged: _changeFalouriteStatus,
      title: Text(_country.name),
      controlAffinity: ListTileControlAffinity.trailing,
      secondary:  Image.network(
        _country.image.path,
        width: 48.0,
        height: 48.0,
      ),
      activeColor: Colors.cyan,
    );
  }
  void _changeFalouriteStatus(bool value) => setState(() => _country.isFavourite = !_country.isFavourite);
}
