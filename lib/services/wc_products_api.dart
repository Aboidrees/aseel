import 'dart:developer';

import 'package:aseel/config.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/services/api_service.dart';
import 'package:dio/dio.dart';

class WCProductsService extends APIService {
  // products Service
  Future<List<ProductModel>> getProducts({
    int? pageNumber,
    int? pageSize,
    String? strSearch,
    String? tagName,
    String? categoryId,
    List<int>? productsIds,
    String? sortBy,
    String? sortOrder = "asc",
  }) async {
    var products = <ProductModel>[];
    try {
      String parameter = "";
      if (strSearch != null) parameter += '&search=$strSearch';
      if (pageSize != null) parameter += '&per_page=$pageSize';
      if (pageNumber != null) parameter += '&page=$pageNumber';
      if (tagName != null) parameter += '&tag=$tagName';
      if (categoryId != null) parameter += '&category=$categoryId';
      if (sortBy != null) parameter += '&orderby=$sortBy';
      if (sortOrder != null) parameter += '&order=$sortOrder';
      if (productsIds != null) parameter += '&include=${productsIds.join(',')}';

      var response = await Dio().get(
        "${EndPoints.products}?consumer_key=${Config.key}&consumer_secret=${Config.secret}$parameter",
        options: requestOptions(),
      );

      if (response.statusCode == 200) {
        for (var product in response.data as List) {
          products.add(ProductModel.fromMap(product));
        }
      }
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return products;
  }

  Future<List<ProductModel>>? getVariableProduct(int productId) async {
    var varProducts = <ProductModel>[];
    try {
      var response = await Dio().get(
        "${EndPoints.productVariations(productId: productId.toString())}?consumer_key=${Config.key}&consumer_secret=${Config.secret}",
        options: requestOptions(),
      );

      if (response.statusCode == 200) {
        for (var varProduct in response.data as List) {
          varProducts.add(ProductModel.fromMap(varProduct));
        }
      }
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return varProducts;
  }
}
