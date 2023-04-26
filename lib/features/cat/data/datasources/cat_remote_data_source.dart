import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/cat_model.dart';
import 'package:http/http.dart' as http;

abstract class CatRemoteDataSource {
  Future<List<CatModel>> getAllCats();
}

const BASE_URL = "api.thecatapi.com";

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  final http.Client client;

  CatRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CatModel>> getAllCats() async {
    final response = await client.get(
      Uri.https(BASE_URL, '/v1/breeds'),
      headers: {'x-api-key': 'bda53789-d59e-46cd-9bc4-2936630fde39'},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      try {
        decodedJson
            .map<CatModel>((jsonCatModel) => CatModel.fromJson(jsonCatModel))
            .toList();
      } catch (e) {
        debugPrint(e.toString());
      }
      final List<CatModel> catModels = decodedJson
          .map<CatModel>((jsonCatModel) => CatModel.fromJson(jsonCatModel))
          .toList();

      return catModels;
    } else {
      throw ServerException();
    }
  }
}
