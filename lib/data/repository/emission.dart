import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/data/model/emission.dart';
import 'package:banknotes/data/model/image.dart';
import 'package:banknotes/data/model/own_banknote.dart';
import 'package:banknotes/domain/model/banknote.dart';
import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/own_banknote.dart';
import 'package:flutter/foundation.dart';

abstract class EmissionRepository {

  /// Get all emissions with Banknotes and OwnBanknotes.
  Future<List<EmissionEntity>> getFullEmissions(int catalogId);
}

class EmissionDbRepository implements EmissionRepository {
  EmissionDbRepository(this.emissionBean);
  final EmissionBean emissionBean;

  @override
  Future<List<EmissionEntity>> getFullEmissions(int catalogId) => throw UnimplementedError();
}

class EmissionMockRepository implements EmissionRepository {

  Description _description = Description.test();

  List<BanknoteEntity> get banknotes => [
    BanknoteEntity.make(0, "1 uah", _description.text, _description.year, _description.printer, _description.entryDate, 1, [], [])..id = 0,
    BanknoteEntity.make(0, "2 uah", _description.text, _description.year, _description.printer, _description.entryDate, 1, [
      ImageEntity.make("resources/images/grn2.jpg", true, describeEnum(ImageType.assets))..id = 0,
      ImageEntity.make("resources/images/grn_all.jpeg", true, describeEnum(ImageType.assets))..id = 1,
    ], [
      OwnBanknoteEntity.make(1, QualityType.fr.toString(), 12.5, Currency().code.toString(), 'comment', [
        ImageEntity.make("resources/images/grn1.jpg", true, describeEnum(ImageType.assets))..id = 0,
        ImageEntity.make("resources/images/grn100.jpg", true, describeEnum(ImageType.assets))..id = 1,
        ImageEntity.make("resources/images/grn1001.jpg", true, describeEnum(ImageType.assets))..id = 2,
        ImageEntity.make("resources/images/grn1.jpg", true, describeEnum(ImageType.assets))..id = 3,
        ImageEntity.make("resources/images/grn100.jpg", true, describeEnum(ImageType.assets))..id = 4,
        ImageEntity.make("resources/images/grn1001.jpg", true, describeEnum(ImageType.assets))..id = 5,


        ImageEntity.make("resources/images/grn100.jpg", true, describeEnum(ImageType.assets))..id = 6,
        ImageEntity.make("resources/images/grn1001.jpg", true, describeEnum(ImageType.assets))..id = 7,
        ImageEntity.make("resources/images/grn1.jpg", true, describeEnum(ImageType.assets))..id = 8,
        ImageEntity.make("resources/images/grn1001.jpg", true, describeEnum(ImageType.assets))..id = 10,
        ImageEntity.make("resources/images/grn1001.jpg", true, describeEnum(ImageType.assets))..id = 11,
        ImageEntity.make("resources/images/grn1.jpg", true, describeEnum(ImageType.assets))..id = 12,
        ImageEntity.make("resources/images/grn100.jpg", true, describeEnum(ImageType.assets))..id = 13,
        ImageEntity.make("resources/images/grn1.jpg", true, describeEnum(ImageType.assets))..id = 14,
        ImageEntity.make("resources/images/grn100.jpg", true, describeEnum(ImageType.assets))..id = 15,
        ImageEntity.make("resources/images/grn1001.jpg", true, describeEnum(ImageType.assets))..id = 16,
        ImageEntity.make("resources/images/grn1.jpg", true, describeEnum(ImageType.assets))..id = 17,
        ImageEntity.make("resources/images/grn100.jpg", true, describeEnum(ImageType.assets))..id = 18,
      ], DateTime.now())..id = 1,
      OwnBanknoteEntity.make(1, QualityType.fr.toString(), 2.5, Currency().code.toString(), 'comment', [], DateTime.now())..id = 2,
      OwnBanknoteEntity.make(1, QualityType.unc.toString(), 1.6, Currency().code.toString(), 'comment', [], DateTime.now())..id = 3,
      OwnBanknoteEntity.make(1, QualityType.g.toString(), 14.4, Currency().code.toString(), 'comment', [], DateTime.now())..id = 4
    ])..id = 1,
    BanknoteEntity.make(0, "5 uah", _description.text, _description.year, _description.printer, _description.entryDate, 2, [], [])..id = 2,
    BanknoteEntity.make(0, "10 uah", _description.text, _description.year, _description.printer, _description.entryDate, 2, [], [])..id = 3,
    BanknoteEntity.make(0, "20 uah", _description.text, _description.year, _description.printer, _description.entryDate, 2, [], [])..id = 4,
    BanknoteEntity.make(0, "50 uah", _description.text, _description.year, _description.printer, _description.entryDate, 3, [], [])..id = 5,
    BanknoteEntity.make(0, "100 uah", _description.text, _description.year, _description.printer, _description.entryDate, 4, [], [])..id = 6,
    BanknoteEntity.make(0, "500 uah", _description.text, _description.year, _description.printer, _description.entryDate, 4, [], [])..id = 7,
  ];

  List<EmissionEntity> get modifications => [
    EmissionEntity.make(0, "1994", banknotes)..id = 0,
    EmissionEntity.make(0, "1997", banknotes)..id = 1,
    EmissionEntity.make(0, "2001", banknotes)..id = 2,
    EmissionEntity.make(0, "2008", banknotes)..id = 3,
    EmissionEntity.make(0, "2010", banknotes)..id = 4,
    EmissionEntity.make(0, "2015", banknotes)..id = 5,
  ];

  @override
  Future<List<EmissionEntity>> getFullEmissions(int catalogId) async {
    await Future.delayed(Duration(seconds: 1));

    return modifications;
  }
}