import 'dart:math';

import 'package:flutter/material.dart';

import '../models/color_model.dart';
import 'package:http/http.dart' as http;

abstract class ColorDataSource {
  Future<ColorModel> getRandomColor();
}

class ColorDataSourceImpl implements ColorDataSource {
  final http.Client client;

  ColorDataSourceImpl({required this.client});
  @override
  Future<ColorModel> getRandomColor() async {
    final decodedJson = Random().nextInt(Colors.primaries.length).toString();
    var resBody = {};
    resBody["color"] = decodedJson;
    final jsonds = Map<String, dynamic>.from(resBody);
    final color = ColorModel.fromJson(jsonds);
    return color;
  }
}
