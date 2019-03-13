import 'package:banknotes/presentation/catalog.dart';
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

  Locale _localeResolutionCallback(
      Locale locale, Iterable<Locale> supportedLocales) {
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
