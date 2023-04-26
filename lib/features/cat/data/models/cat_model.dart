import '../../../../core/helpers/get_data_fromJson.dart';
import '../../domain/entities/Cat.dart';

class CatModel extends Cats {
  const CatModel(
      {required super.id,
      required super.name,
      required super.origin,
      required super.countryCodes,
      required super.countryCode,
      required super.description,
      required super.intelligence,
      required super.referenceImageId,
      required super.lifeSpan,
      required super.adaptability});

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
        id: json['id'] ?? '',
        origin: json['origin'] ?? '',
        name: json['name'] ?? '',
        countryCode: json['countryCode'] ?? '',
        countryCodes: json['countryCodes'] ?? '',
        description: json['description'] ?? '',
        intelligence: json['intelligence'] ?? 0,
        lifeSpan: json['life_span'] ?? '',
        adaptability: json['adaptability'] ?? 0,
        referenceImageId: getImage(json['reference_image_id']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'countryCode': countryCode,
      'description': description,
      'intelligence': intelligence,
      'origin': origin,
      'countryCodes': countryCodes,
      'life_span': lifeSpan,
      'adaptability': adaptability,
      'reference_image_id': referenceImageId
    };
  }
}
