import 'package:flutter/cupertino.dart';

//class BottomPicker extends StatefulWidget {
//
//  BottomPicker(this.items, this.initialStateIndex);
//
//  final List<String> items;
//  final int initialStateIndex;
//
//  @override
//  State<StatefulWidget> createState() => BottomPickerState();
//}
//
//class BottomPickerState extends State<BottomPicker> {
//
//  int _initialStateIndex;
//
//  @override
//  void initState() {
//    super.initState();
//    _initialStateIndex = widget.initialStateIndex;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final FixedExtentScrollController scrollController =
//    FixedExtentScrollController(initialItem: _initialStateIndex);
//
//    return _buildBottomPicker(
//      CupertinoPicker(
//        scrollController: scrollController,
//        itemExtent: 32.0,
//        backgroundColor: CupertinoColors.white,
//        onSelectedItemChanged: (int index) => setState(() => _initialStateIndex = index),
//        children: List<Widget>.generate(widget.items.length, (int index) {
//          return Center(child: Text(widget.items[index]));
//        }),
//      ),
//    );
//  }
//
//  Widget _buildBottomPicker(Widget picker) {
//    return Container(
//      height: 216.0,
//      padding: const EdgeInsets.only(top: 6.0),
//      color: CupertinoColors.white,
//      child: DefaultTextStyle(
//        style: const TextStyle(
//          color: CupertinoColors.black,
//          fontSize: 22.0,
//        ),
//        child: GestureDetector(
//          // Blocks taps from propagating to the modal sheet and popping.
//          onTap: () { },
//          child: SafeArea(
//            top: false,
//            child: picker,
//          ),
//        ),
//      ),
//    );
//  }
//}

typedef OnBottomPickerSelectedListener = void Function(int index);

class BottomPicker extends StatelessWidget {

  BottomPicker({
    @required this.items,
    this.initialStateIndex,
    this.onBottomPickerSelectedListener
  });
  
  final List<String> items;
  final int initialStateIndex;
  final OnBottomPickerSelectedListener onBottomPickerSelectedListener;
  
  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController scrollController =
    FixedExtentScrollController(initialItem: initialStateIndex ?? 0);

    return _buildBottomPicker(
      CupertinoPicker(
        scrollController: scrollController,
        itemExtent: 32.0,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: onBottomPickerSelectedListener,
        children: List<Widget>.generate(
          items.length, (index) => Center(child: Text(items[index])),
        ),
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () { },
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}