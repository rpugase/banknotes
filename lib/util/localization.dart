import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  Localization(this.locale);

  final Locale locale;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, dynamic> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('resources/lang/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value is String ? value.toString() : Map<String, String>.from(value);
    });

    return true;
  }

  String get countries => _sentences['countries'];
  String get catalogs => _sentences['full_catalogs'];
  String get noData => _sentences['no_data'];
  String get error => _sentences['error'];
  String get close => _sentences['close'];
  String get price => _sentences['price'];
  String get comment => _sentences['comment'];
  String get errorEmpty => _sentences['error_empty'];
  String get add => _sentences['add'];
  String get create => _sentences['create'];
  String get change => _sentences['change'];
  String get shoppingPrice => _sentences['shopping_price'];
  String get shoppingDate => _sentences['shopping_date'];
  String get banknoteDescriptionPrinter => _sentences['printer'];
  String get banknoteDescription => _sentences['description'];
  String get banknoteDescriptionYear => _sentences['description_year'];
  String get banknoteDescriptionEntryDate => _sentences['entry_date'];
  String get faceValue => _sentences['face_value'];
  String get quality => _sentences['quality'];
  Map<String, String> get qualityMap => _sentences['quality_map'];
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) async {
    Localization localizations = Localization(locale);
    await localizations.load();

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
