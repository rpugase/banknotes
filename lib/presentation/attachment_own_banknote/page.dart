import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:flutter/material.dart';

class AttachmentOwnBanknotePage extends StatefulWidget {

  AttachmentOwnBanknotePage();

  @override
  State<StatefulWidget> createState() => _AttachmentOwnBanknoteState();
}

class _AttachmentOwnBanknoteState extends State<AttachmentOwnBanknotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Text('Тут будет добавление купленной банкноты'),
    );
  }
}


