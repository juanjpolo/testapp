import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/cat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CatLocalDataSource {
  Future<List<CatModel>> getCachedPosts();
  Future<Unit> cachePosts(List<CatModel> catModels);
}

const CACHED_POSTS = "CACHED_POSTS";

class CatLocalDataSourceImpl implements CatLocalDataSource {
  final SharedPreferences sharedPreferences;

  CatLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<CatModel> catModels) {
    List catModelsToJson = catModels
        .map<Map<String, dynamic>>((catModel) => catModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(catModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CatModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CatModel> jsonTocatModels = decodeJsonData
          .map<CatModel>((jsoncatModel) => CatModel.fromJson(jsoncatModel))
          .toList();
      return Future.value(jsonTocatModels);
    } else {
      throw EmptyCacheException();
    }
  }
}