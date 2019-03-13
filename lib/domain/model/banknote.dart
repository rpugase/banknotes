import 'package:banknotes/domain/model/image.dart';

class Banknote {
  Banknote(this.id, this.quality,
      {this.price, this.currency, this.comment, this.images, this.date});

  final int id;
  final String price;
  final String currency;
  final _QualityType quality;
  final String comment;
  final List<Image> images;
  final DateTime date;
}

enum _QualityType { good, bad }
