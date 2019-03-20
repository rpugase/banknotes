import 'package:banknotes/domain/model/banknote.dart';
import 'package:flutter/material.dart';

class BanknoteDetailsPage extends StatefulWidget {
  Banknote _banknote;

  BanknoteDetailsPage(this._banknote);

  @override
  State<StatefulWidget> createState() => _BanknoteDetailsPageState();
}

class _BanknoteDetailsPageState extends State<BanknoteDetailsPage> {
  double _heightAppBar = 0.0;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(widget._banknote.name),
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _addOwnBanknote(),
        ),
      ],
    );

    _heightAppBar = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          _createImageView(),
        ],
      ),
    );
  }

  void _addOwnBanknote() {}

  Widget _createImageView() {
    return Container(
      color: Colors.blueGrey,
      child: Image.asset(
        widget._banknote.firstBanknoteImage.path,
        width: MediaQuery.of(context).size.width,
        height: 200.0,
      ),
    );
  }
}
