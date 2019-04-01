import 'dart:io';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/widget/image_viewer.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:banknotes/domain/model/image.dart';

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
            onPressed: () => _showSimpleDialog(),
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
      body: _buildView(),
    );
  }

  Widget _buildView() {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(8),
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
    ));
  }

  List<ImageWidget> _showAllImages() {
    final List<ImageWidget> imageWidgets = [];

    for (int i = 0; i < widget._ownBanknote.images.length; i++) {
      imageWidgets.add(ImageWidget(
          widget._ownBanknote.images[i].path, widget._ownBanknote, i));
    }
    return imageWidgets;
  }

  Future<void> _showSimpleDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              _getDialogCell(true, Localization.of(context).gallery),
              _getDialogCell(false, Localization.of(context).camera),
            ],
          );
        });
  }

  Widget _getDialogCell(bool isGallery, String title) {
    return SimpleDialogOption(
      onPressed: () {
        _getImage(isGallery);
        Navigator.pop(context);
      },
      child: Text(title),
    );
  }

  Future<void> _getImage(bool isGallery) async {
    await ImagePicker.pickImage(
            source: isGallery ? ImageSource.gallery : ImageSource.camera)
        .then((value) {
      setState(() {
        var image = ImageModel(value.path, ImageType.device);
        widget._ownBanknote.images.add(image);
      });
    });
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
              Localization.of(context).faceValue, _banknote.name),
          _createDescriptionLine(Localization.of(context).shoppingPrice,
              '${_ownBanknote.price}${_ownBanknote.currency.symbol}'),
          _createDescriptionLine(
              Localization.of(context).banknoteDescriptionYear,
              _banknote.description.year),
          _createDescriptionLine(Localization.of(context).quality,
              _ownBanknote.quality.toString()),
          _createDescriptionLine(
              Localization.of(context).comment, _ownBanknote.comment),
        ]);
  }

  Widget _createDescriptionLine(String title, String value) {
    return Padding(
      padding: EdgeInsets.all(8),
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
  final OwnBanknote _ownBanknote;
  final int _numberImageInGrid;

  final String _heroTag = 'OwnBanknoteDetailPage';

  ImageWidget(this._imagePath, this._ownBanknote, this._numberImageInGrid);

  @override
  Widget build(BuildContext context) {
    var image = Padding(
      padding: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
      child: Hero(
          tag: '$_heroTag$_numberImageInGrid',
          child: Image.asset(
            _imagePath,
            fit: BoxFit.cover,
          )),
    );

    return Container(
      child: GestureDetector(
        onTap: () => _showAllImages(context),
        child: image,
      ),
    );
  }

  void _showAllImages(BuildContext context) {
    List<String> images =
        _ownBanknote.images.map((image) => image.path).toList();

    Navigator.of(context).push(
      PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child:
                        ImageViewerPage(images, _numberImageInGrid, _heroTag),
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 600)),
    );
  }
}