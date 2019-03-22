import 'package:banknotes/data/model/own_banknote.dart';
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
  
  OwnBanknote.fromEntity(OwnBanknoteEntity entity) :
        id = entity.id, 
        price = entity.price, 
        currency = Currency.fromStringCode(entity.currency), 
        quality = QualityType.values.firstWhere((quality) => quality.toString() == entity.quality),
        comment = entity.comment, 
        images = entity.images.map((image) => Image.fromEntity(image)).toList(),
        date = entity.date;

  OwnBanknoteEntity toEntity() => OwnBanknoteEntity.make(
      quality.toString(),
      price,
      currency.toString(),
      comment,
      images.map((image) => image.toEntity()).toList(),
      date
  );
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
