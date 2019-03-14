import 'package:flutter/material.dart';
import 'package:banknotes/util/localization.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/presentation/full_catalog/bloc.dart';
import 'package:banknotes/domain/model/catalog.dart';

class FullCatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullCatalogPageState();
}

class _FullCatalogPageState extends State<FullCatalogPage> {

  FullCatalogBloc _bloc = Injector().fullCatalogBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).catalogs),

      ),
      body: StreamBuilder<FullCatalogState>(
        stream: _bloc.catalogStream,
        initialData: CatalogInitState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          FullCatalogState _catalogState = snapshot.data;

          if (_catalogState is CatalogInitState) {
            return _buildInit();
          } else if (_catalogState is CatalogLoadingState) {
            return _buildLoading();
          }
          else if (_catalogState is CatalogDataState) {
            CatalogDataState catalogDataState = _catalogState;
            return _buildContent(catalogDataState.catalogs);
          }
        },
      ),

    );
  }

  Widget _buildInit() {
    _bloc.loadCatalogs();
    return Container();
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
      activeColor: Colors.red,
    );
  }
  void _changeFalouriteStatus(bool value) => setState(() => _country.isFavourite = !_country.isFavourite);
}
