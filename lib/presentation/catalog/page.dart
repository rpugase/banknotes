import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/presentation/catalog/bloc.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  CatalogBloc _bloc = Injector().catalogBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.loadCatalogs();

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
      body: StreamBuilder<CatalogState>(
        stream: _bloc.catalogStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          CatalogState _catalogState = snapshot.data;

          if (_catalogState is CatalogLoadingState) {
            return _buildLoading();
          }
          else if (_catalogState is CatalogEmptyDataState) {
            return _buildEmpty();
          }
          else if (_catalogState is CatalogDataState) {
            CatalogDataState catalogDataState = _catalogState;
            return _buildContent(catalogDataState.catalogs);
          }
        },
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
    return ListView.separated(
      itemBuilder: (context, index) => _CatalogHolder(catalogs[index]),
      itemCount: catalogs.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class _CatalogHolder extends StatelessWidget {
  _CatalogHolder(this._country);

  final Catalog _country;

  @override
  Widget build(BuildContext context) {
    return Container(
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
}
