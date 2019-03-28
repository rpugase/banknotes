
import 'package:banknotes/domain/model/banknote.dart';
import 'package:flutter/material.dart';

class BanknoteImageDetailPage extends StatefulWidget {

  BanknoteImageDetailPage();

  @override
  State<StatefulWidget> createState()  => _BanknoteImageDetailState();

}

class _BanknoteImageDetailState extends State<BanknoteImageDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Text('Тут будут фото'),
    );
  }
}