import 'package:banknotes/domain/model/face_value.dart';

class Modification {
  Modification(this.id, this.name, [this.faceValues]);

  final int id;
  final String name;
  final List<FaceValue> faceValues;
}
