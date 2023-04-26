import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../../../core/helpers/get_data_fromJson.dart';

Cats catsFromJson(String str) => Cats.fromJson(json.decode(str));

class Cats extends Equatable {
  const Cats(
      {required this.id,
      required this.name,
      required this.origin,
      required this.countryCodes,
      required this.countryCode,
      required this.description,
      required this.intelligence,
      required this.referenceImageId,
      required this.adaptability,
      required this.lifeSpan});

  final String id;
  final String name;
  final String? referenceImageId;
  final String origin;
  final String countryCodes;
  final String countryCode;
  final String description;
  final int intelligence;
  final String? lifeSpan;
  final int? adaptability;
  factory Cats.fromJson(Map<String, dynamic> json) => Cats(
      id: json["id"],
      name: json["name"],
      origin: json["origin"],
      countryCodes: json["country_codes"],
      countryCode: json["country_code"],
      description: json["description"],
      intelligence: json["intelligence"],
      lifeSpan: getLifeSpan(json['life_span']),
      adaptability: getAdaptability(json['adaptability']),
      referenceImageId: getImage(json['reference_image_id']));

  @override
  List<Object?> get props => [
        adaptability,
        lifeSpan,
        id,
        name,
        origin,
        countryCode,
        countryCodes,
        description,
        intelligence,
        referenceImageId
      ];
}

class Weight {
  Weight({
    required this.imperial,
    required this.metric,
  });

  final String imperial;
  final String metric;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        imperial: json["imperial"],
        metric: json["metric"],
      );

  Map<String, dynamic> toJson() => {
        "imperial": imperial,
        "metric": metric,
      };
}
