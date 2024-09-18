// woocommerce.login(email, password);
import 'package:aseel/main.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_client/woocommerce_client.dart';

class UserProvider with ChangeNotifier {



  login(String email, String password) async {
    await woocommerce.customersGet();
    notifyListeners();
  }
}
