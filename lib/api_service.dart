import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aseel/config.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/models/category.dart';
import 'package:aseel/models/customer_model.dart';
import 'package:aseel/models/login%20_response_model.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/token.dart';
import 'package:dio/dio.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode("${Config.key}:${Config.secret}"),
    );

    bool ret = false;

    try {
      var response = await Dio().post(
        EndPoints.customers,
        data: model.toJson(),
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) ret = true;
    } on DioError catch (e) {
      log(json.decode(e.response.toString())['message']);
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<LoginResponseModel?> login(String username, String password) async {
    try {
      var response = await Dio().post(
        EndPoints.token,
        data: FormData.fromMap({"username": username, "password": password}),
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"},
        ),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromMap(response.data);
      }
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return null;
  }

  Future<List<Category>> getCategories() async {
    var categories = <Category>[];
    try {
      var url = "${EndPoints.categories}?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response = await Dio().get(
        url.toString(),
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
      );
      if (response.statusCode == 200) {
        for (var category in response.data as List) {
          if (category['name'] != "Uncategorized") {
            categories.add(Category.fromMap(category));
          }
        }
      }
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return categories;
  }

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

      var url = "${EndPoints.products}?consumer_key=${Config.key}&consumer_secret=${Config.secret}$parameter";

      var response = await Dio().get(
        url.toString(),
        options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
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

  Future<CartDetailsModel?> addToCart(AddToCartModel addToCartParams) async {
    try {
      var response = await Dio().post(
        EndPoints.addToCart,
        data: addToCartParams.toJson(),
        options: Options(headers: {HttpHeaders.authorizationHeader: "Bearer $token", HttpHeaders.contentTypeHeader: "application/json"}),
      );
      if (response.statusCode == 200) return CartDetailsModel.fromMap(response.data);
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return null;
  }

  Future<CartDetailsModel?> getCartDetails() async {
    try {
      var response = await Dio().get(
        EndPoints.getCart,
        options: Options(headers: {HttpHeaders.authorizationHeader: "Bearer $token", HttpHeaders.contentTypeHeader: "application/json"}),
      );

      if (response.statusCode == 200) {
        return CartDetailsModel.fromJson(response.data);
      } else {
        log(response.toString());
        return null;
      }
    } on DioError catch (e) {
      log(e.response.toString());
      return null;
    }
  }
}
