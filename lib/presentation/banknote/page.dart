import 'package:flutter/material.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/modification.dart';
import 'package:banknotes/util/error_handler.dart';
import 'package:banknotes/presentation/widget/reorderable_list.dart';

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
      ),
      body: _isLoading ? _buildLoading() : _buildBanknotes(),
    );
  }

  Widget _buildBanknotes() {
    return ListView.separated(
      itemBuilder: (context, index) => _buildBanknoteList(index),
      itemCount: _banknotes.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
    );
  }

  Widget _buildBanknoteList(int index) {
    var banknote = _banknotes[index];

    return FutureBuilder(
      future: banknote.getFirstBanknoteImage(),
      builder: (context, text){

        return ListTile (
          title: Text(banknote.name),
          key: Key(banknote.id.toString()),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: text.hasData ? Image.asset(
              text.data,
          width: 50.0,
          height: 50.0,
        ) :  _buildLoading(),
        trailing: Icon(Icons.check, color: Colors.green,),
//      onTap: () =>(){},
        );
      }
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
