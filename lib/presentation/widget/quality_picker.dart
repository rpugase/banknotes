import 'dart:math';

import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/widget/quality_type_widget.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnQualitySelectedListener = void Function(QualityType qualityType);

class QualityPicker extends StatefulWidget {

  QualityPicker({
    Key key,
    this.qualityType,
    this.qualitySelectedListener
  }) : super(key: key);

  final QualityType qualityType;
  final OnQualitySelectedListener qualitySelectedListener;

  @override
  State<StatefulWidget> createState() => _QualityPickerState();
}

class _QualityPickerState extends State<QualityPicker> {

  final List<QualityTypeWidget> _qualityTypes = QualityType.values.map((qualityType) => QualityTypeWidget(qualityType)).toList();
  List<String> _qualityTexts;

  double _type;

  @override
  void initState() {
    super.initState();
    _type = QualityType.values.indexOf(widget.qualityType ?? QualityType.pr).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    _qualityTexts ??= Localization.of(context).qualityMap.values.toList();

    return Column(
      children: <Widget>[
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            _qualityTexts[min(_type.toInt(), _qualityTypes.length - 1)],
            style: TextStyle(fontSize: 16.0),
          ),
        )),
        Center(child: Row(children: _qualityTypes.map((qtWidget) => Flexible(child: qtWidget, flex: 1)).toList())),
        Slider(
          max: _qualityTypes.length.toDouble(),
          value: _type,
          onChanged: (value) => setState(() {
            _type = value;
            widget.qualitySelectedListener(_qualityTypes[min(_type.toInt(), _qualityTypes.length - 1)].qualityType);
          }),
        ),
      ],
    );
  }
}
