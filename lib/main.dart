import 'dart:convert';

import 'package:banknotes/data/model/catalog.dart';
import 'package:banknotes/presentation/catalog_page.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  Injector().init(SqfliteAdapter(await getDatabasesPath(), version: 1));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();

}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    loadpp(context);
    super.initState();
  }

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
        buttonColor: Colors.purple,
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

  void loadpp(BuildContext context) async {
    List<dynamic> decoded = jsonDecode(await DefaultAssetBundle.of(context).loadString('resources/banknoteDB.json'));

    var catalogBean = Injector.catalogBean;

    await Injector.sqfliteAdapter.connect();

    await catalogBean.createTable(ifNotExists: true);

    List<CatalogEntity> list = await catalogBean.getAll();

    if (list.isEmpty) {
      list = decoded.map((catalog) => CatalogEntity.fromJson(catalog)).toList();
      await catalogBean.insertMany(list);
    }

    await Injector.sqfliteAdapter.close();
  }

}
