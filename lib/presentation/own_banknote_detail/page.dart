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
      body: _loadView(),
    );
  }

  Widget _loadView() {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DescriptionWidget(widget._banknote, widget._ownBanknote),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildListDelegate(_showAllImages()),
          ),
        ],
      ),
    );
  }

  List<ImageWidget> _showAllImages() {
    return widget._ownBanknote.images
        .map((image) => ImageWidget(image.path))
        .toList();
  }
}

class DescriptionWidget extends StatelessWidget {
  final Banknote _banknote;
  final OwnBanknote _ownBanknote;
  DescriptionWidget(this._banknote, this._ownBanknote);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createDescriptionLine(
              '${Localization.of(context).faceValue}', '${_banknote.name}'),
          _createDescriptionLine('${Localization.of(context).shoppingPrice}',
              '${_ownBanknote.price}${_ownBanknote.currency.symbol}'),
          _createDescriptionLine(
              '${Localization.of(context).banknoteDescriptionYear}',
              _banknote.description.year),
          _createDescriptionLine(
              '${Localization.of(context).quality}', '${_ownBanknote.quality}'),
          _createDescriptionLine(
              '${Localization.of(context).comment}', '${_ownBanknote.comment}'),
        ]);
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

class ImageWidget extends StatelessWidget {
  final String _imagePath;

  ImageWidget(this._imagePath);

  @override
  Widget build(BuildContext context) {
    return _createImage(context);
  }

  Widget _createImage(BuildContext context) {
    var image =  Image.asset(
      _imagePath,
      fit: BoxFit.cover,
    );

    return Container(
      child: GestureDetector(
        onTap: (){},
        child: image,
      ),
    );
  }

}
