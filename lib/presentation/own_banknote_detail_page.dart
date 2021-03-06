import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/widget/image_viewer.dart';
import 'package:banknotes/presentation/widget/own_banknote_creator.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:banknotes/util/utils_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OwnBanknoteDetailPage extends StatefulWidget {
  final OwnBanknote _ownBanknote;
  final Banknote _banknote;

  OwnBanknoteDetailPage(this._ownBanknote, this._banknote);

  @override
  State<StatefulWidget> createState() => _OwnBanknoteDetailState();
}

class _OwnBanknoteDetailState extends State<OwnBanknoteDetailPage> {

  OwnBanknote _ownBanknote;
  final DataManager _dataManager = Injector().dataManager;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _ownBanknote = widget._ownBanknote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = _buildDialogAttachmentPhoto();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => showCustomDialog(context, widgets),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _changeBanknote,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showDialogBanknote,
          )
        ],
      ),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    return Container(
      child: Padding(padding: EdgeInsets.all(8),
      child: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [DescriptionWidget(widget._banknote, _ownBanknote)],
            ),
          ),
          SliverGrid(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildListDelegate(_showAllImages()),
          ),
        ],
      ),)
    );
  }

  List<ImageWidget> _showAllImages() {
    final List<ImageWidget> imageWidgets = [];

    for (int i = 0; i < widget._ownBanknote.images.length; i++) {
      imageWidgets.add(ImageWidget(_ownBanknote.images[i].path, widget._ownBanknote, i, _controller));
    }
    return imageWidgets;
  }

  void _showDialogBanknote() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _buildDialogDeletingBanknote()
    );
  }


Widget _buildDialogDeletingBanknote() {
  return CupertinoAlertDialog(
    title: Text(Localization.of(context).deleteQuestion),
    actions: <Widget>[
       CupertinoButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(Localization.of(context).cancel),
      ),
       CupertinoButton(
          onPressed: () {
            _dataManager.deleteOwnBanknote(widget._banknote, widget._ownBanknote)
                .then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                })
                .catchError((error) => showError(context, error));

          },
          child: Text(Localization.of(context).yes)),
    ],
  );
}

  void _changeBanknote() async {
    final ownBanknote = await showCustomDialog(
        context,
        [OwnBanknoteCreator(widget._banknote, _ownBanknote)],
        barrierDismissible: false
    );

    if (ownBanknote != null) setState(() => _ownBanknote = ownBanknote);
  }


  List<Widget> _buildDialogAttachmentPhoto() {
    return [
      _setDialogCell(true, Localization.of(context).gallery),
      Divider(),
      _setDialogCell(false, Localization.of(context).camera)];
  }

  Widget _setDialogCell(bool isGallery, String title) {
    return SimpleDialogOption(
      onPressed: () {
        _getImage(isGallery);
        Navigator.pop(context);
      },
      child: Center(child: Text(title)),
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
  final ScrollController _controller;

  int imageCount = 0;
  final String _heroTag = 'OwnBanknoteDetailPage';

  ImageWidget(this._imagePath, this._ownBanknote, this._numberImageInGrid, this._controller);

  @override
  Widget build(BuildContext context) {
    var image = Padding(
        padding: EdgeInsets.all(8.0),
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

  void _showAllImages(BuildContext context) async {
    List<String> images = _ownBanknote.images.map((image) => image.path).toList();

    int offsetImageNumber = await Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: ImageViewerPage(images, _numberImageInGrid, _heroTag),
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 600)),
    );

    _controller.jumpTo(100 * (offsetImageNumber / 3));
  }
}
