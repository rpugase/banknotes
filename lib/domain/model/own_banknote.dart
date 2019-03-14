import 'package:banknotes/domain/model/image.dart';

class OwnBanknote {
  OwnBanknote(this.id, this.quality,
      {this.price, this.currency, this.comment, this.images, this.date});

  final int id;
  final double price;
  final Currency currency;
  final QualityType quality;
  final String comment;
  final List<Image> images;
  final DateTime date;
}

class Currency {

  Currency([this.code = CurrencyCode.usd]);

  final CurrencyCode code;
  String get symbol => (code == CurrencyCode.usd) ? '\$' : '€';
}

enum CurrencyCode { usd, eur }

enum QualityType { good, bad }
