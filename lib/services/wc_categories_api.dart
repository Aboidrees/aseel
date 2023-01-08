import 'dart:developer';

import 'package:aseel/config.dart';
import 'package:aseel/models/category.dart';
import 'package:aseel/services/api_service.dart';
import 'package:dio/dio.dart';

class WCCategoriesService extends APIService {
  // category Service
  Future<List<CategoryModel>> getCategories() async {
    var categories = <CategoryModel>[];
    try {
      var url = "${EndPoints.categories}?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response = await Dio().get(url.toString(), options: requestOptions());

      if (response.statusCode == 200) {
        for (var category in response.data as List) {
          if (category['name'] != "Uncategorized") {
            categories.add(CategoryModel.fromMap(category));
          }
        }
      }
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return categories;
  }
}
