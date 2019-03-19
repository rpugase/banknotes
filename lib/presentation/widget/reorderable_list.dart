import 'package:flutter/material.dart';

class ReorderableList extends ReorderableListView {

  ReorderableList(
      {
        BuildContext context,
        Widget header,
        @required Iterable<Widget> tiles,
        @required Color color,
        @required ReorderCallback onReorder,
        Axis scrollDirection = Axis.vertical,
        EdgeInsets padding,
        bool reverse = false
      })
      : super(
            header: header,
            children: _divideTiles(context: context, tiles: tiles, color: color).toList(),
            onReorder: onReorder,
            scrollDirection: scrollDirection,
            padding: padding,
            reverse: reverse);

  static Iterable<Widget> _divideTiles({BuildContext context, @required Iterable<Widget> tiles, Color color}) sync* {
    assert(tiles != null);
    assert(color != null || context != null);

    final Iterator<Widget> iterator = tiles.iterator;
    final bool isNotEmpty = iterator.moveNext();

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context, color: color),
      ),
    );

    Widget tile = iterator.current;
    while (iterator.moveNext()) {
      yield DecoratedBox(
        key: UniqueKey(),
        position: DecorationPosition.foreground,
        decoration: decoration,
        child: tile,
      );
      tile = iterator.current;
    }
    if (isNotEmpty) yield tile;
  }
}
