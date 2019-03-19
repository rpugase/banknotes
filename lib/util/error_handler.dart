import 'package:banknotes/util/localization.dart';
import 'package:flutter/material.dart';

void showError(BuildContext context, Error error, [Function func]) {
  if (func != null) func();

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(Localization.of(context).error),
            content: Text(error.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text(Localization.of(context).cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
