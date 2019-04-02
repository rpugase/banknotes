import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

void showError(BuildContext context, Error error, [Function func]) {
  if (func != null) func();

  print(error.stackTrace);

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(Localization.of(context).error),
            content: Text(error.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text(Localization.of(context).close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

Future<T> showCustomDialog<T>(BuildContext context, List<Widget> children, {barrierDismissible: true}) {
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_context) {
        return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            children: children
        );
      });
}