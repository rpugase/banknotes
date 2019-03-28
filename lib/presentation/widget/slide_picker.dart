import 'package:flutter/cupertino.dart';

typedef OnSliderPickerSelectedListener = void Function(int index);

class SlidePicker extends StatelessWidget {

  SlidePicker({
    @required this.items,
    this.initialStateIndex,
    this.onSliderPickerSelectedListener
  });
  
  final List<String> items;
  final int initialStateIndex;
  final OnSliderPickerSelectedListener onSliderPickerSelectedListener;
  
  @override
  Widget build(BuildContext context) {
    return _buildSlidePicker(
      CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialStateIndex ?? 0),
        itemExtent: 32.0,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: onSliderPickerSelectedListener,
        children: List<Widget>.generate(
          items.length, (index) => Center(child: Text(items[index])),
        ),
      ),
    );
  }

  Widget _buildSlidePicker(Widget picker) {
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