import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/modification.dart';
import 'package:banknotes/util/error_handler.dart';
import 'package:banknotes/util/injector.dart';
import 'package:flutter/material.dart';

class BanknotePage extends StatefulWidget {

  BanknotePage(this._modification);
  final Modification _modification;

  @override
  State<StatefulWidget> createState() => _BanknotePageState();
}

class _BanknotePageState extends State<BanknotePage> {

  final DataManager _dataManager = Injector().dataManager;
  bool _isLoading = true;
  Map<int, List<Banknote>> _banknotes = {};


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
      ),
      body: _isLoading ? _buildLoading() : _buildBanknotes(),
    );
  }

  Widget _buildBanknotes() {
    List<Widget> items = [];

    _banknotes.forEach((parentId, banknotes) {
      items.add(_ExpansionBanknoteItem(Key(parentId.toString()), banknotes));
    });

    return ListView.separated(
      itemBuilder: (context, index) => items[index],
      itemCount: items.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey, height: 0),
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

class _ExpansionBanknoteItem extends StatelessWidget {
  _ExpansionBanknoteItem(Key key, this._banknotes) : super(key: key);

  final List<Banknote> _banknotes;

  @override
  Widget build(BuildContext context) {
    return _banknotes.length == 1 ? _buildSimple(_banknotes.first, true) : _buildExpansion();
  }

  Widget _buildExpansion() {
    return ExpansionTile(
      title: Text(_banknotes.first.name),
      leading: Image.asset(
        _banknotes.first.firstBanknoteImage.path,
        width: 50.0,
        height: 50.0,
      ) ,
      trailing: Icon(Icons.keyboard_arrow_down),
      children: _banknotes.map((banknote) => _buildSimple(banknote, false)).toList(),
    );
  }

  Widget _buildSimple(Banknote banknote, final bool main) {
    return ListTile(
      dense: false,
      title: Text(banknote.name),
      contentPadding: EdgeInsets.symmetric(horizontal: main ? 16.0 : 24.0, vertical: 8.0),
      leading:  Image.asset(
        banknote.firstBanknoteImage.path,
        width: 50.0,
        height: 50.0,
      ) ,
      trailing: banknote.ownBanknotes.isNotEmpty ? Icon(Icons.check, color: Colors.green) : null,
    );
  }
}