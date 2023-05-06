import 'dart:convert';

ColorRandom colorRandomFromJson(String str) =>
    ColorRandom.fromJson(json.decode(str));

String colorRandomToJson(ColorRandom data) => json.encode(data.toJson());

class ColorRandom {
  final String color;

  ColorRandom({
    required this.color,
  });

  factory ColorRandom.fromJson(Map<String, dynamic> json) => ColorRandom(
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
      };
}
