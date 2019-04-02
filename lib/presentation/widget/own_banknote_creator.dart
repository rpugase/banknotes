import 'package:banknotes/domain/data_manager.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:banknotes/presentation/widget/quality_picker.dart';
import 'package:banknotes/presentation/widget/slide_picker.dart';
import 'package:banknotes/util/utils_functions.dart';
import 'package:banknotes/util/injector.dart';
import 'package:banknotes/util/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnBanknoteCreator extends StatefulWidget {

  OwnBanknoteCreator(this.banknote, [this.ownBanknote]);

  final Banknote banknote;
  final OwnBanknote ownBanknote;

  @override
  State<StatefulWidget> createState() => _OwnBanknoteCreatorState(
      ownBanknote?.quality,
      ownBanknote?.price?.toString(),
      ownBanknote?.comment,
      ownBanknote?.currency
  );
}

class _OwnBanknoteCreatorState extends State<OwnBanknoteCreator> {

  _OwnBanknoteCreatorState([QualityType qualityType, String price,
      String comment, Currency currency]) :
        _priceController = _PriceEditingController(text: price ?? ''),
        _commentController = TextEditingController(text: comment ?? ''),
        _qualityType = qualityType ?? QualityType.f;

  final DataManager _dataManager = Injector().dataManager;

  final List<Currency> _currencies = Currency.all;
  final _PriceEditingController _priceController;
  final TextEditingController _commentController;

  int _currencyIndex = 0;
  QualityType _qualityType;

  bool get _isCreator => widget.ownBanknote == null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        QualityPicker(
          qualityType: _qualityType,
          qualitySelectedListener: (qualityType) => _qualityType = qualityType,
        ),
        Stack(
          fit: StackFit.passthrough,
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            _TextField(
                Localization.of(context).price,
                _priceController,
                TextInputType.number
            ),
            _buildCurrencyPicker(context),
          ],
        ),
        _TextField(
            Localization.of(context).comment, 
            _commentController,
            TextInputType.multiline
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text(Localization.of(context).close),
                onPressed: _onClosePressed,
              ),
              RaisedButton(
                child: Text(_isCreator ? Localization.of(context).create : Localization.of(context).change),
                onPressed: _onAddPressed,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyPicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => SlidePicker(
            items: _currencies.map((currency) => currency.symbol).toList(),
            initialStateIndex: _currencyIndex,
            onSliderPickerSelectedListener: (index) => setState(() => _currencyIndex = index),
          )
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          _currencies[_currencyIndex].symbol,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _onAddPressed() {
    final OwnBanknote ownBanknote = OwnBanknote(
      _qualityType,
      _priceController.text.isEmpty ? 0.0 : double.parse(_priceController.text),
      _currencies[_currencyIndex],
      _commentController.text,
      widget.ownBanknote?.images ?? [],
      id: widget.ownBanknote?.id,
      date: widget.ownBanknote?.date,
    );

    if (_isCreator) {
      _dataManager.addOwnBanknote(widget.banknote, ownBanknote)
          .then((nothing) => Navigator.of(context).pop(ownBanknote),
          onError: (error) => showError(context, error));
    } else {
      _dataManager.changeOwnBanknote(widget.banknote, ownBanknote)
          .then((nothing) => Navigator.of(context).pop(ownBanknote),
          onError: (error) => showError(context, error));
    }
  }
}

class _TextField extends StatefulWidget {

  _TextField(this._hint, this._controller, this._keyboardType);

  final String _hint;
  final TextEditingController _controller;
  final TextInputType _keyboardType;

  String get text => _controller.text;

  @override
  State<StatefulWidget> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: TextFormField(
          decoration: InputDecoration(hintText: widget._hint),
          controller: widget._controller,
          keyboardType: widget._keyboardType,
          validator: (value) => value.isEmpty ? Localization.of(context).errorEmpty : null,
        ),
      ),
    );
  }
}

class _PriceEditingController extends TextEditingController {

  _PriceEditingController({String text}) : super(text: text) {
    this.addListener(() {
      if (this.text.contains('.')) {
        var parts = this.text.split('.');
        if (parts.length > 2 || parts[1].length > 2) {
          _removeLast();
        }
      }
    });
  }

  void _removeLast() {
    text = text.substring(0, text.length - 1);
    this.selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}