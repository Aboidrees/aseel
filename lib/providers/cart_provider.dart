import 'package:aseel/api_service.dart';
import 'package:aseel/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  late APIService _apiService;
  late CartDetailsModel? _cartDetails;

  CartProvider() {
    _apiService = APIService();
    _cartDetails = CartDetailsModel();
    initialize();
    notifyListeners();
  }

  CartDetailsModel? get cartDetails => _cartDetails;

  initialize() {
    _apiService.getCartDetails().then((value) {
      _cartDetails = value;
      notifyListeners();
    });
  }

  void addToCart(AddToCartModel payload, {Function? onCallback}) async {
    await _apiService.addToCart(payload).then((cartDetails) {
      if (cartDetails != null) _cartDetails = cartDetails;
      if (onCallback != null) onCallback();
      notifyListeners();
    });
  }
}
