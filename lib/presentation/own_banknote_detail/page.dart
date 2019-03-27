import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

class OwnBanknoteDetailPage extends StatefulWidget {
  OwnBanknote _ownBanknote;
  Banknote _banknote;

  OwnBanknoteDetailPage(this._ownBanknote, this._banknote);

  @override
  State<StatefulWidget> createState() => _OwnBanknoteDetailState();
}

class _OwnBanknoteDetailState extends State<OwnBanknoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
      body: _createListView(),
    );
  }

  Widget _createListView() {
    return ListView(
      children: <Widget>[_createDescriptionView()],
    );
  }

  Widget _createDescriptionView() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createDescriptionLine('${Localization.of(context).faceValue}',
              '${widget._banknote.name}'),
          _createDescriptionLine('${Localization.of(context).shoppingPrice}',
              '${widget._ownBanknote.price}${widget._ownBanknote.currency.symbol}'),
          _createDescriptionLine(
              '${Localization.of(context).banknoteDescriptionYear}',
              widget._banknote.description.year),
          _createDescriptionLine('${Localization.of(context).quality}',
              '${widget._ownBanknote.quality}'),
          _createDescriptionLine('${Localization.of(context).comment}',
              '${widget._ownBanknote.comment}'),
          _showExistingImages()
        ]);
  }

  List<Widget> _performImage(int rowCount) {
    List<Widget> items = [];
    for (var i = 0; i < 3; i++) {
      items.add(Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 24),
        child: GestureDetector(
          onTap: () {},
          child: Image.asset(
              widget._ownBanknote.images[(rowCount * 3) + i].path,
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.width / 4,
              alignment: Alignment.center,
              fit: BoxFit.cover),
        ),
      ));
    }

    return items;
  }

  Widget _showExistingImages() {
    List<Widget> items = [];
    var imagesCount = widget._ownBanknote.images.length;
    var multiplicityImagesCount = imagesCount / 3;
    if (multiplicityImagesCount != multiplicityImagesCount.toInt()) {
      multiplicityImagesCount += 1;
    }

    while (multiplicityImagesCount.toInt() > 0) {
      items.add(Container(
        child: Column(
          children: <Widget>[Row(children: _performImage(0))],
        ),
      ));
      multiplicityImagesCount -= 1;
    }

    return Column(
      children: items,
    );
  }

  Widget _createDescriptionLine(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: TextStyle(
              fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
                text: value, style: TextStyle(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
