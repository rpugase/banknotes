import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/catalog/page.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale settings
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      localizationsDelegates: [
        LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: _localeResolutionCallback,

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CatalogPage(),
    );
  }

  Locale _localeResolutionCallback(Locale locale,
      Iterable<Locale> supportedLocales) {
    if (locale != null)
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode ||
            supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }

    return supportedLocales.first;
  }
}


class TestMyApp extends StatelessWidget {

  List<Banknote> get banknotes => [
    Banknote(0, "1 uah", "desc", ownBanknotes: []),
    Banknote(1, "2 uah", "desc", ownBanknotes: [OwnBanknote(0, QualityType.good, price: 12.5, currency: Currency(), date: DateTime.now())]),
    Banknote(2, "5 uah", "desc", ownBanknotes: []),
    Banknote(3, "10 uah", "desc", ownBanknotes: []),
    Banknote(4, "20 uah", "desc", ownBanknotes: []),
    Banknote(5, "50 uah", "desc", ownBanknotes: []),
    Banknote(6, "100 uah", "desc", ownBanknotes: []),
    Banknote(7, "500 uah", "desc", ownBanknotes: []),
  ];

  Map<int, List<Banknote>> get map => {
    1: [Banknote(0, "1 uah", "desc", ownBanknotes: [])],
    2: [Banknote(1, "2 uah", "desc", ownBanknotes: [OwnBanknote(0, QualityType.good, price: 12.5, currency: Currency(), date: DateTime.now())])],
    3: banknotes
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    map.forEach((parentId, banknotes) {
      items.add(_ExpansionBanknoteItem(Key(parentId.toString()), banknotes));
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Test')),
        body: ListView.separated(
          itemBuilder: (context, index) => items[index],
          itemCount: items.length,
          separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey, height: 0),

        ),
      ),
    );
  }
}

class _ExpansionBanknoteItem extends StatelessWidget {
  _ExpansionBanknoteItem(Key key, this._banknotes) : super(key: key);

  final List<Banknote> _banknotes;

  @override
  Widget build(BuildContext context) {
    return _banknotes.length == 1 ? _buildSimple(_banknotes.first, true) : _buildExpansion();
  }

  Widget _buildExpansion() {
    return ExpansionTile(
      title: Text(_banknotes.first.name),
      leading: Image.asset(
        _banknotes.first.firstBanknoteImage.path,
        width: 50.0,
        height: 50.0,
      ) ,
      trailing: Icon(Icons.keyboard_arrow_down),
      children: _banknotes.map((banknote) => _buildSimple(banknote, false)).toList(),
    );
  }

  Widget _buildSimple(Banknote banknote, final bool main) {
    return ListTile(
      dense: false,
      title: Text(banknote.name),
      contentPadding: EdgeInsets.symmetric(horizontal: main ? 16.0 : 24.0, vertical: 8.0),
      leading:  Image.asset(
        banknote.firstBanknoteImage.path,
        width: 50.0,
        height: 50.0,
      ) ,
      trailing: banknote.ownBanknotes.isNotEmpty ? Icon(Icons.check, color: Colors.green) : null,
//      onTap: () =>(){},
    );
  }
}