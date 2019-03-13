import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final DataManager _dataManager = Injector().dataManager;
  final List<Catalog> _catalogs = [];

  _CatalogPageState() {
    _dataManager.getFavouriteCatalogs().then((List<Catalog> catalogs) {
      setState(() {
        _catalogs.addAll(catalogs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).countries),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => _CatalogHolder(_catalogs[index]),
        itemCount: _catalogs.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.grey),
      ),
    );
  }
}

class _CatalogHolder extends StatelessWidget {
  _CatalogHolder(this._country);

  final Catalog _country;

  @override
  Widget build(BuildContext context) =>
      Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              Image.network(
                _country.image.path,
                width: 48.0,
                height: 48.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(_country.name),
              ),
            ],
          ));
}
