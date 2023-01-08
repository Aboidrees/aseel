import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aseel/config.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:aseel/models/customer_model.dart';
import 'package:aseel/models/login_response_model.dart';
import 'package:aseel/token.dart';
import 'package:dio/dio.dart';

class APIService {
  String basicAuth = "Basic ${base64.encode(utf8.encode("${Config.key}:${Config.secret}"))}";
  String bearerAuth = "Bearer $token";

  Options requestOptions({String? authHeader}) {
    Map<String, dynamic> headers = {};
    if (authHeader != null) {
      headers.addAll({HttpHeaders.authorizationHeader: authHeader});
    }
    headers.addAll({HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});

    return Options(headers: headers);
  }

  // account service
  Future<bool> createCustomer(CustomerModel customer) async {
    bool ret = false;

    try {
      var response = await Dio().post(EndPoints.customers, data: customer.toJson(), options: requestOptions(authHeader: basicAuth));

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

  // Auth Service
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
