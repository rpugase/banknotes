import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/catalog.dart';
import 'package:banknotes/domain/model/modification.dart';
import 'package:banknotes/util/error_handler.dart';
import 'package:banknotes/util/injector.dart';
import 'package:flutter/material.dart';
import '';

class ModificationPage extends StatefulWidget {

  ModificationPage(this._catalog);
  final Catalog _catalog;

  @override
  State<StatefulWidget> createState() {
    return _ModificationPageState();
  }
}

class _ModificationPageState extends State<ModificationPage> {

  final DataManager _dataManager = Injector().dataManager;

  bool _isLoading = true;
  List<Modification> _modifications;

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
      body: _isLoading ? _buildLoading() : _buildModifications(),
    );
  }

  void _loadData() {
    _dataManager.getModifications(widget._catalog).then((modifications) {
      setState(() {
        _isLoading = false;
        _modifications = modifications;
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

  Widget _buildModifications() {
    return ListView.separated(
        itemBuilder: (context, index) => _buildItem(_modifications[index]),
        separatorBuilder: (context, index) => Divider(color: Colors.grey),
        itemCount: _modifications.length,
    );
  }

  Widget _buildItem(Modification modification) {
    return ListTile(
      title: Text(modification.name),
      trailing: Text('${modification.ownBanknotesLength} / ${modification.banknotesLength}'),
      onTap: () {
        _openBanknotePage();
      },
    );
  }

  void _openBanknotePage() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => BanknotePage()));

    _loadData();
  }
}