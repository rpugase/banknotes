import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/emission.dart';
import 'package:banknotes/presentation/banknote_page.dart';
import 'package:banknotes/util/error_handler.dart';
import 'package:banknotes/util/injector.dart';
import 'package:flutter/material.dart';

class EmissionPage extends StatefulWidget {

  EmissionPage(this._catalog);
  final Catalog _catalog;

  @override
  State<StatefulWidget> createState() {
    return _EmissionPageState();
  }
}

class _EmissionPageState extends State<EmissionPage> {

  final DataManager _dataManager = Injector().dataManager;

  bool _isLoading = true;
  List<Emission> _emissions = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._catalog.name),
      ),
      body: _isLoading ? _buildLoading() : _buildEmissions(),
    );
  }

  void _loadData() {
    _dataManager.getEmissions(widget._catalog).then((emissions) {
      setState(() {
        _isLoading = false;
        _emissions = emissions;
      });
    }, onError: (error) => showError(context, error, _onError));
  }

  void _onError() {
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildEmissions() {
    return ListView.separated(
        itemBuilder: (context, index) => _buildItem(_emissions[index]),
        separatorBuilder: (context, index) => Divider(color: Colors.grey),
        itemCount: _emissions.length,
    );
  }

  Widget _buildItem(Emission emission) {
    return ListTile(
      title: Text(emission.name),
      trailing: Text('${emission.ownBanknotesLength} / ${emission.banknotesLength}'),
      onTap: () {
        _openBanknotePage(emission);
      },
    );
  }

  void _openBanknotePage(Emission emission) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => BanknotePage(emission)));

    _loadData();
  }
}