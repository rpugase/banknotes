import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:flutter/material.dart';

class OwnBanknoteDetailPage extends StatefulWidget {
  OwnBanknote _ownBanknote;


  OwnBanknoteDetailPage(this._ownBanknote);

  @override
  State<StatefulWidget> createState() => _OwnBanknoteDetailState();
}

class _OwnBanknoteDetailState extends State<OwnBanknoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Text('Тут будет детализация купленной банкноты'),
    );
  }
}
