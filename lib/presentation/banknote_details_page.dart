import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/own_banknote_detail_page.dart';
import 'package:banknotes/presentation/widget/own_banknote_creator.dart';
import 'package:banknotes/presentation/widget/quality_type_widget.dart';
import 'package:banknotes/presentation/widget/reordeble_list.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:banknotes/util/utils_functions.dart';
import 'package:flutter/material.dart';

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
            child: _createImageView(),
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
                    return CustomReorderableItem(
                      key: Key(_ownBanknotes[index].id.toString()),
                      isFirst: index == 0,
                      isLast: index == _ownBanknotes.length - 1,
                      onItemCreate: (context) => _createOwnBanknoteCell(context, _ownBanknotes[index]),
                    );
                  },
                  childCount: _ownBanknotes.length,
                ),
              )),
        ]),
      ),
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

  Widget _createImageView() {
    return GestureDetector(
        onTap: () => _openAllImages(widget._banknote),
        child: Container(
          color: Colors.blueGrey,
          child: Image.asset(
            widget._banknote.firstBanknoteImage.path,
            width: MediaQuery.of(context).size.width,
            height: 200.0,
          ),
        ));
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _getIndexByKey(item);
    int newPositionIndex = _getIndexByKey(newPosition);

    _dataManager.replaceOwnBanknotesPositions(
      widget._banknote,
      _ownBanknotes[draggingIndex],
      _ownBanknotes[newPositionIndex],
    ).then((ownBanknotes) => setState(() => _ownBanknotes = ownBanknotes),
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
          _createDescriptionLine(
              Localization.of(context).banknoteDescription,
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
              text:  TextSpan(
                text: '$title: ',
                style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                   TextSpan(
                      text: value,
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
    );
  }

  void _openAllImages(Banknote banknote) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('No implementation')));
  }

  void _addOwnBanknote() async {
    final OwnBanknote ownBanknote = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        children: [OwnBanknoteCreator(widget._banknote)],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      )
    );

    if (ownBanknote != null) setState(() {});
  }

  void _showOwnBanknote(OwnBanknote ownBanknote, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OwnBanknoteDetailPage(ownBanknote, widget._banknote))
    );
  }
}
