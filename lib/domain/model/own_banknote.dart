import 'package:banknotes/data/model/own_banknote.dart';
import 'package:banknotes/domain/model/image.dart';

class OwnBanknote {
  OwnBanknote(this.quality, this.price, this.currency, this.comment, this.images, {this.id, DateTime date})
      : this.date = date ?? DateTime.now();

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

  OwnBanknoteEntity toEntity(int banknotesId) => OwnBanknoteEntity.make(
      banknotesId,
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

  String get symbol => getSymbolByCode(_code);

  static List<String> get codes => CurrencyCode.values.map(getSymbolByCode).toList();
  static List<Currency> get all => CurrencyCode.values.map((code) => Currency(code)).toList();
  static String getSymbolByCode(CurrencyCode currencyCode) => (currencyCode == CurrencyCode.usd) ? '\$' : '€';

  @override
  String toString() => _code.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Currency &&
              runtimeType == other.runtimeType &&
              _code == other._code;

  @override
  int get hashCode => _code.hashCode;

}

enum CurrencyCode { usd, eur }

enum QualityType { pr, fr, g, vg, f, vf, ef, au, unc }
