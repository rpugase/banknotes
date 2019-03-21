import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/attachment_own_banknote/page.dart';
import 'package:banknotes/presentation/banknote_image_detail/page.dart';
import 'package:banknotes/presentation/own_banknote_detail/page.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

class BanknoteDetailsPage extends StatefulWidget {
  Banknote _banknote;

  BanknoteDetailsPage(this._banknote);

  @override
  State<StatefulWidget> createState() => _BanknoteDetailsPageState();
}

class _BanknoteDetailsPageState extends State<BanknoteDetailsPage> {
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

    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          _createImageView(),
          _createDescriptionView(),
          _createOwnBanknoteList(widget._banknote.ownBanknotes)
        ],
      ),
    );
  }

  Widget _createImageView() {
    return GestureDetector(
        onTap: () =>  _openAllImages(widget._banknote),
        child: Container(
          color: Colors.blueGrey,
          child: Image.asset(
            widget._banknote.firstBanknoteImage.path,
            width: MediaQuery.of(context).size.width,
            height: 200.0,
          ),
        ));
  }

  Widget _createDescriptionView() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Text(
              '1 гривна — наименьшая по номиналу банкнота в денежном обороте современной Украины. Введена в обращение Национальным банком в 1996 году.',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          )
        ]);
  }

  Widget _createOwnBanknoteList(List<OwnBanknote> ownBanknotes) {
    final children = <Widget>[];
    for (var ownBanknote in ownBanknotes) {
      children.add(_createOwnBanknoteCell(ownBanknote));
    }
    return Column(children: children);
  }

  Widget _createOwnBanknoteCell(OwnBanknote ownBanknote) {
    return GestureDetector(
      onTap: () => _showOwnBanknote(ownBanknote),
      child: Container(
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  'resources/images/quality.png',
                  width: 30.0,
                  height: 30.0,
                )),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${Localization.of(context).shoppingPrice}${ownBanknote.price} ${ownBanknote.currency.symbol}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    Text(
                      '${Localization.of(context).shoppingDate}${ownBanknote.formatDate()}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ],
                )),
//        Padding(
//          padding: EdgeInsets.all(8.0),
//          child: Text(
//
//            'Очень важная банкнота, купленная в Киеве, летом 2014',
//            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8),
//          ),
//        ),
          ],
        ),
      ),
    );
  }

  void _showOwnBanknote(OwnBanknote ownBanknote) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OwnBanknoteDetailPage(ownBanknote)));
  }

  void _openAllImages(Banknote banknote) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BanknoteImageDetailPage(banknote)));
  } //AttachmentOwnBanknotePage

  void _addOwnBanknote() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AttachmentOwnBanknotePage()));
  }
}
