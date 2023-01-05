import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aseel/config.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/models/category.dart';
import 'package:aseel/models/customer_model.dart';
import 'package:aseel/models/login_response_model.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/token.dart';
import 'package:dio/dio.dart';

class APIService {
  Options requestOptions({String? authHeader}) {
    Map<String, dynamic> headers = {};
    if (authHeader != null) {
      headers.addAll({HttpHeaders.authorizationHeader: authHeader});
    }
    headers.addAll({HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});

    return Options(headers: headers);
  }

  Future<bool> createCustomer(CustomerModel customer) async {
    var authToken = base64.encode(
      utf8.encode("${Config.key}:${Config.secret}"),
    );

    bool ret = false;

    try {
      var response = await Dio().post(
        EndPoints.customers,
        data: customer.toJson(),
        options: requestOptions(authHeader: "Basic $authToken"),
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

      var response = await Dio().get(url.toString(), options: requestOptions());

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

      var response = await Dio().get(url.toString(), options: requestOptions());

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

  Future<CartDetailsModel?> getCartDetails() async {
    try {
      var response = await Dio().get(EndPoints.getCart, options: requestOptions(authHeader: "Bearer $token"));

      if (response.statusCode == 200) {
        return CartDetailsModel.fromMap(response.data);
      } else {
        log(response.toString());
        return null;
      }
    } on DioError catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  Future<CartDetailsModel?> addToCart(AddToCartModel addToCartParams) async {
    try {
      var response = await Dio().post(
        EndPoints.addToCart,
        data: addToCartParams.toJson(),
        options: requestOptions(authHeader: "Bearer $token"),
      );
      if (response.statusCode == 200) return CartDetailsModel.fromMap(response.data);
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return null;
  }

  Future<CartDetailsModel?> updateProduct(String itemKey, String quantity) async {
    try {
      var response = await Dio().post(
        EndPoints.cartItem(itemKey),
        data: FormData.fromMap({"quantity": quantity}),
        options: requestOptions(authHeader: "Bearer $token"),
      );
      if (response.statusCode == 200) return CartDetailsModel.fromMap(response.data);
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return null;
  }

  Future<bool?> removeProduct(String itemKey) async {
    try {
      var response = await Dio().delete(
        EndPoints.cartItem(itemKey),
        options: requestOptions(authHeader: "Bearer $token"),
      );
      if (response.statusCode == 200) return true;
    } on DioError catch (e) {
      log(e.response.toString());
    }
    return null;
  }
}
