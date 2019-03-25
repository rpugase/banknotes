import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/attachment_own_banknote/page.dart';
import 'package:banknotes/presentation/banknote_image_detail/page.dart';
import 'package:banknotes/presentation/own_banknote_detail/page.dart';
import 'package:banknotes/presentation/widget/reordeble_list_with_scrollView.dart';
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
      body: ReorderableList(
        onReorder: _reorderCallback,
        onReorderDone: _reorderDone,
        child: CustomScrollView(slivers: <Widget>[
          SliverToBoxAdapter(
            // Put here all widgets that are not slivers.
            child: _createImageView(),
          ),
          SliverToBoxAdapter(
            // Put here all widgets that are not slivers.
            child: _createDescriptionView(),
          ),
          SliverPadding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Item(
                          data: widget._banknote.ownBanknotes[index],
                          // first and last attributes affect border drawn during dragging
                          isFirst: index == 0,
                          isLast: index == widget._banknote.ownBanknotes.length - 1,

                        );
                  },
                  childCount: widget._banknote.ownBanknotes.length,
                ),
              )),
        ]
//
            ),
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
    int draggingIndex =  _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final draggedItem = widget._banknote.ownBanknotes[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      widget._banknote.ownBanknotes.removeAt(draggingIndex);
      widget._banknote.ownBanknotes.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  int _indexOfKey(Key key) {
    return widget._banknote.ownBanknotes.indexWhere((OwnBanknote d) => Key(d.id.toString()) == key);
  }

  void _reorderDone(Key item) {
    final draggedItem = widget._banknote.ownBanknotes[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.price}");
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

  void _openAllImages(Banknote banknote) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BanknoteImageDetailPage(banknote)));
  } //AttachmentOwnBanknotePage

  void _addOwnBanknote() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AttachmentOwnBanknotePage()));
  }
}

class Item extends StatelessWidget {
  Item({
    this.data,
    this.isFirst,
    this.isLast,
  });

  final OwnBanknote data;
  final bool isFirst;
  final bool isLast;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    // For iOS dragging mdoe, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = Container();

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                        child:
                        _createOwnBanknoteCell(data, context),
                      )),
                  // Triggers the reordering
                  dragHandle,
                ],
              ),
            ),
          )),
    );

      content = DelayedReorderableListener(
        child: content,
      );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: Key(data.id.toString()), //
        childBuilder: _buildChild);
  }

  Widget _createOwnBanknoteCell(OwnBanknote ownBanknote, BuildContext context) {
    return GestureDetector(
      onTap: () => _showOwnBanknote(ownBanknote, context),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'resources/images/quality.png',
                  width: 30.0,
                  height: 30.0,
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${Localization.of(context).shoppingPrice}${ownBanknote.price} ${ownBanknote.currency.symbol}',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      '${Localization.of(context).shoppingDate}${ownBanknote.formatDate()}',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                )),
            Padding(

                padding: EdgeInsets.all(10),
                child: Icon(Icons.menu),
            ),
          ],
        ),
      ),
    );
  }

  void _showOwnBanknote(OwnBanknote ownBanknote, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OwnBanknoteDetailPage(ownBanknote)));
  }
}