import '../../domain/entities/color_entitie.dart';

class ColorModel extends ColorRandom {
  ColorModel({
    required super.color,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      color: json['color'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'color': color,
    };
  }
}
