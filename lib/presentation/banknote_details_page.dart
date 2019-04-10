import 'dart:async';

import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/own_banknote_detail_page.dart';
import 'package:banknotes/presentation/widget/image_viewer.dart';
import 'package:banknotes/presentation/widget/own_banknote_creator.dart';
import 'package:banknotes/presentation/widget/quality_type_widget.dart';
import 'package:banknotes/presentation/widget/reordeble_list.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:banknotes/util/utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BanknoteDetailsPage extends StatefulWidget {
  final Banknote _banknote;

  BanknoteDetailsPage(this._banknote);

  @override
  State<StatefulWidget> createState() => _BanknoteDetailsPageState(_banknote.ownBanknotes);
}

class _BanknoteDetailsPageState extends State<BanknoteDetailsPage> {
  final DataManager _dataManager = Injector().dataManager;

  _BanknoteDetailsPageState(this._ownBanknotes);
  List<OwnBanknote> _ownBanknotes;
  final heroTag = 'BanknoteDetailsPage';
  final imageNumberTag = 'BanknoteDetailsPage_imageNumber';
  ScrollController _controller;
  int imageCount = 0;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(widget._banknote.name),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _addOwnBanknote,
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: ReorderableList(
        onReorder: _reorderCallback,
        child: CustomScrollView(slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                 controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    child: _createImageView(index),
                    margin: EdgeInsets.all(5.0),
                  ),
                  itemCount: widget._banknote.images.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _createDescriptionView(),
          ),
          SliverPadding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Slidable(
                      delegate: SlidableStrechDelegate(),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: Localization.of(context).delete,
                          color: Colors.red,
                          icon: Icons.archive,
                          onTap: () => _dataManager.deleteOwnBanknote(widget._banknote,
                              widget._banknote.ownBanknotes[index])
                              .then(((value) => setState(() {})))
                              .catchError((error) => showError(context, error)),
                        ),
                      ],
                      child: CustomReorderableItem(
                        key: Key(_ownBanknotes[index].id.toString()),
                        isFirst: index == 0,
                        isLast: index == _ownBanknotes.length - 1,
                        onItemCreate: (context) => _createOwnBanknoteCell(context, _ownBanknotes[index]),
                      ),
                    );
                  },
                  childCount: widget._banknote.ownBanknotes.length,
                ),
              )),
        ]),
      ),
    );
  }

  void _showOwnBanknote(OwnBanknote ownBanknote, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OwnBanknoteDetailPage(ownBanknote, widget._banknote))
    );
  }

  Widget _createOwnBanknoteCell(BuildContext context, OwnBanknote ownBanknote) {
    return ListTile(
      onTap: () => _showOwnBanknote(ownBanknote, context),
      title: Text(
        '${Localization.of(context).shoppingPrice}: ${ownBanknote.price} ${ownBanknote.currency.symbol}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        '${Localization.of(context).shoppingDate}: ${ownBanknote.formatDate()}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      leading: QualityTypeWidget(ownBanknote.quality, 30.0),
      trailing: Icon(Icons.menu),
    );
  }

  Widget _createImageView(int index) {
    var image = Image.asset(
      widget._banknote.images[index].path,
      width: MediaQuery.of(context).size.width,
      height: 200.0,
    );

    return GestureDetector(
        onTap: () =>_openSelectedImage(index),
        child: Container(
          child: Hero(
            tag: '$heroTag$index',
            child: image,
          ),
        ));
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _getIndexByKey(item);
    int newPositionIndex = _getIndexByKey(newPosition);

    _dataManager
        .replaceOwnBanknotesPositions(
          widget._banknote,
          _ownBanknotes[draggingIndex],
          _ownBanknotes[newPositionIndex],
        )
        .then((ownBanknotes) => setState(() => _ownBanknotes = ownBanknotes),
            onError: (error) => showError(context, error));
    return true;
  }

  int _getIndexByKey(Key key) {
    return _ownBanknotes.indexWhere((ownBanknote) => Key(ownBanknote.id.toString()) == key);
  }

  Widget _createDescriptionView() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createDescriptionLine(
              Localization.of(context).banknoteDescriptionEntryDate,
              widget._banknote.description.entryDate),
          _createDescriptionLine(Localization.of(context).banknoteDescription,
              widget._banknote.description.text),
          _createDescriptionLine(
              Localization.of(context).banknoteDescriptionYear,
              widget._banknote.description.year),
          _createDescriptionLine(
              Localization.of(context).banknoteDescriptionPrinter,
              widget._banknote.description.printer),
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

  void _addOwnBanknote() async {
    final OwnBanknote ownBanknote = await showCustomDialog(
        context,
        [OwnBanknoteCreator(widget._banknote)],
        barrierDismissible: false
    );

    if (ownBanknote != null) setState(() {});
  }

  void _getImageCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imageCount = prefs.get(imageNumberTag);
    var screenWidth = MediaQuery.of(context).size.width;
    _controller.jumpTo(screenWidth * imageCount);
    prefs.setInt(imageNumberTag, null);
  }

  void _openSelectedImage(int numberImage) {
    List<String> images = widget._banknote.images.map((image) => image.path).toList();
    Navigator.of(context).push(
      PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: ImageViewerPage(images, numberImage, heroTag),
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 600)),
    ).then((value) {
      setState(() {
        _getImageCount();
      });
    });
  }
}
