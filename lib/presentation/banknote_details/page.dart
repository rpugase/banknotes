import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/banknote_image_detail/page.dart';
import 'package:banknotes/presentation/own_banknote_detail/page.dart';
import 'package:banknotes/presentation/widget/own_banknote_creator.dart';
import 'package:banknotes/presentation/widget/quality_type_widget.dart';
import 'package:banknotes/presentation/widget/reordeble_list_with_scroll_view.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

class BanknoteDetailsPage extends StatefulWidget {
  final Banknote _banknote;

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
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _addOwnBanknote(),
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
                    return Item(widget._banknote,
                      data: widget._banknote.ownBanknotes[index],
                      isFirst: index == 0,
                      isLast: index == widget._banknote.ownBanknotes.length - 1,
                    );
                  },
                  childCount: widget._banknote.ownBanknotes.length,
                ),
              )),
        ]),
      ),
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

    setState(() {
      final draggedItem = widget._banknote.ownBanknotes.removeAt(draggingIndex);
      widget._banknote.ownBanknotes.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  int _getIndexByKey(Key key) {
    return widget._banknote.ownBanknotes
        .indexWhere((ownBanknote) => Key(ownBanknote.id.toString()) == key);
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
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BanknoteImageDetailPage()));
  }

  void _addOwnBanknote() async {
    final OwnBanknote ownBanknote = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        elevation: 24.0,
        children: [OwnBanknoteCreator(widget._banknote)],
      )
    );

    if (ownBanknote != null) setState(() {});
  }
}

class Item extends StatelessWidget {

  Item(this._banknote, {
    this.data,
    this.isFirst,
    this.isLast,
  });

  final Banknote _banknote;
  final OwnBanknote data;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(key: Key(data.id.toString()), childBuilder: _buildChild);
  }

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context)
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    Widget content = Container(
      decoration: decoration,
      child: Opacity(
        opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(child: _createOwnBanknoteCell(data, context)),
            ],
          ),
        ),
      ),
    );

    return DelayedReorderableListener(child: content);
  }

  Widget _createOwnBanknoteCell(OwnBanknote ownBanknote, BuildContext context) {
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

  void _showOwnBanknote(OwnBanknote ownBanknote, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OwnBanknoteDetailPage(ownBanknote, _banknote))
    );
  }
}
