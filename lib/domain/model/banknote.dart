import 'package:banknotes/data/model/banknote.dart';
import 'package:banknotes/domain/model/image.dart';
import 'package:banknotes/domain/model/own_banknote.dart';

class Banknote {
  Banknote(this.id, this.name, this.description, this.parentId,
      { this.images = const [], this.ownBanknotes = const [] });

  final int id;
  final String name;
  final Description description;
  final int parentId;
  final List<Image> images;
  final List<OwnBanknote> ownBanknotes;

  Image get firstBanknoteImage =>
     images.isNotEmpty ? images.first : Image('resources/images/no_image_icon.png', ImageType.assets);


  Banknote.fromEntity(BanknoteEntity entity) :
        id = entity.id,
        name = entity.name,
        description = Description(entity.description, entity.year, entity.printer, entity.entryDate),
        parentId = entity.parentId,
        images = entity.images.map((image) => Image.fromEntity(image)).toList(),
        ownBanknotes = entity.ownBanknotes.map((ownBanknote) => OwnBanknote.fromEntity(ownBanknote)).toList();

  BanknoteEntity toEntity(int emissionId) => BanknoteEntity.make(
      emissionId,
      name,
      description.text,
      description.year,
      description.printer,
      description.entryDate,
      parentId,
      images.map((image) => image.toEntity()).toList(),
      ownBanknotes.map((ownBanknote) => ownBanknote.toEntity(id)).toList()
  );
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