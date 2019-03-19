import 'package:flutter/material.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/modification.dart';
import 'package:banknotes/util/error_handler.dart';

class BanknotePage extends StatefulWidget {

  BanknotePage(this._modification);
  final Modification _modification;

  @override
  State<StatefulWidget> createState() => _BanknotePageState();
}

class _BanknotePageState extends State<BanknotePage> {

  final DataManager _dataManager = Injector().dataManager;
  bool _isLoading = true;
  List<Banknote> _banknotes = [];


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._modification.name),
        actions: <Widget>[
        ],
      ),
      body: _isLoading ? _buildLoading() : _buildBanknotes(),
    );
  }

  Widget _buildBanknotes() {
    return ListView.separated(
      itemBuilder: (context, index) => _BanknoteHolder(_banknotes[index]),
      itemCount: _banknotes.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  void _onError() {
    setState(() {  _isLoading = false; });
  }


  void _loadData() {
      _dataManager.getBanknotes(widget._modification).then((banknotes) {
        setState(() {
          _isLoading = false;
          _banknotes = banknotes;
        });
      }, onError: (error) => showError(context, error, _onError));
  }
}

class _BanknoteHolder extends StatefulWidget {
  _BanknoteHolder(this._banknote);

  final Banknote _banknote;

  @override
  State<StatefulWidget> createState() {
    return MyWidgetState(_banknote);
  }
}

class MyWidgetState extends State<_BanknoteHolder> {

  MyWidgetState(this._banknote);

  final Banknote _banknote;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _banknote.ownBanknotes.length > 0,
      title: Text(_banknote.name),
      controlAffinity: ListTileControlAffinity.trailing,

      activeColor: Colors.purple,
    );
  }
}