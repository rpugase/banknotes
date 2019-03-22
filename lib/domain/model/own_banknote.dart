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

  Currency([this._code = CurrencyCode.usd]);
  Currency.fromStringCode(String codeString) {
    _code = (codeString == CurrencyCode.usd.toString()) ? CurrencyCode.usd : CurrencyCode.eur;
  }

  CurrencyCode _code;
  CurrencyCode get code => _code;

  String get symbol => (_code == CurrencyCode.usd) ? '\$' : '€';

  @override
  String toString() => _code.toString();
}

enum CurrencyCode { usd, eur }

enum QualityType { good, bad }
