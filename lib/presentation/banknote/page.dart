import 'package:flutter/material.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/domain/data_manager.dart';

class BanknotePage extends StatefulWidget {
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
        title: Text(''),
        actions: <Widget>[
        ],
      ),
      body: Container(

      ),
    );
  }


  List<Banknote> _loadData() {

  }
}