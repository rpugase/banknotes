import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

class Banknote {
  Banknote(this.id, this.name, this.description, this.parentId,
      { List<Image> images, List<OwnBanknote> ownBanknotes }) {
    if (images != null) _images.addAll(images);
    if (ownBanknotes != null) _ownBanknotes.addAll(ownBanknotes);
  }

  final int id;
  final String name;
  final Description description;
  final int parentId;
  List<Image> _images = [];
  List<OwnBanknote> _ownBanknotes = [];

  List<Image> get images => _images;
  List<OwnBanknote> get ownBanknotes => _ownBanknotes;
  Image get firstBanknoteImage =>
     _images.isNotEmpty ? _images.first : Image('resources/images/no_image_icon.png', ImageType.assets);


  Banknote.fromEntity(BanknoteEntity entity) :
        id = entity.id,
        name = entity.name,
        description = Description(entity.description, entity.year, entity.printer, entity.entryDate),
        parentId = entity.parentId,
        _images = entity.images.map((image) => Image.fromEntity(image)).toList(),
        _ownBanknotes = entity.ownBanknotes.map((ownBanknote) => OwnBanknote.fromEntity(ownBanknote)).toList();

  BanknoteEntity toEntity(int emissionId) => BanknoteEntity.make(
      emissionId,
      name,
      description.text,
      description.year,
      description.printer,
      description.entryDate,
      parentId,
      _images.map((image) => image.toEntity()).toList(),
      _ownBanknotes.map((ownBanknote) => ownBanknote.toEntity(id)).toList()
  );

  static Map<int, List<Banknote>> toMap(List<BanknoteEntity> banknotes) {
    final Map<int, List<Banknote>> map = {};

    banknotes.forEach((banknote) {
      if (map[banknote.parentId] == null) {
        map[banknote.parentId] = [Banknote.fromEntity(banknote)];
      } else {
        map[banknote.parentId].add(Banknote.fromEntity(banknote));
      }
    });

    return map;
  }
}

class Description {

  Description(this.text, this.year, this.printer, this.entryDate);
  Description.test() :
        text = 'Большое такое описание с всякими там приколами вот такие вот дела',
        year = '1994',
        printer = 'ООО Гридин Интертеймент',
        entryDate = 'Сентябрь 1998';

  final String text;
  final String year;
  final String printer;
  final String entryDate;

}