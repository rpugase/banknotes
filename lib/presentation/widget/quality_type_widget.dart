import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QualityTypeWidget extends StatelessWidget {

  QualityTypeWidget(this.qualityType, [this.size]) : _color = _getColor(qualityType);

  final QualityType qualityType;
  final Color _color;
  final int size;

  @override
  Widget build(BuildContext context) {
    final boxSize = size ?? MediaQuery.of(context).size.width / QualityType.values.length - 4;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: _color,
        width: boxSize,
        height: boxSize,
        alignment: Alignment.center,
        child: Text(
          describeEnum(qualityType).toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static Color _getColor(QualityType qualityType) {
    Color color;

    switch (qualityType) {
      case QualityType.pr:
        color = Colors.red;
        break;
      case QualityType.fr:
        color = Colors.deepOrangeAccent;
        break;
      case QualityType.g:
        color = Colors.orange;
        break;
      case QualityType.vg:
        color = Colors.orangeAccent;
        break;
      case QualityType.f:
        color = Colors.yellow;
        break;
      case QualityType.vf:
        color = Colors.green;
        break;
      case QualityType.ef:
        color = Colors.green[600];
        break;
      case QualityType.au:
        color = Colors.green[700];
        break;
      case QualityType.unc:
        color = Colors.green[800];
        break;
    }

    return color;
  }
}