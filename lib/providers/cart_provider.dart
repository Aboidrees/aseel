import 'package:aseel/models/cart_model.dart';
import 'package:aseel/services/api_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  late APIService _apiService;
  late CartDetailsModel? _cartDetails;

  double get totalRecords => _cartDetails?.items?.length.toDouble() ?? 0.0;

  double get totalAmount => _cartDetails?.items?.isNotEmpty ?? false
      ? _cartDetails?.items?.map((e) => e.quantity * e.price / 100).reduce((sum, nextValue) => sum += nextValue) ?? 0.0
      : 0.0;

  List<CartItemModel> get items => _cartDetails?.items ?? <CartItemModel>[];

  CartProvider() {
    _apiService = APIService();
    _cartDetails = CartDetailsModel();
    updateCartDetails();
    notifyListeners();
  }

  CartDetailsModel? get cartDetails => _cartDetails;

  resetStream() {
    _apiService = APIService();
    _cartDetails = CartDetailsModel();
  }

  Future<void> updateCartDetails({Function? onCallback}) async {
    if (cartDetails == null) resetStream();

    _apiService.getCartDetails().then((value) {
      _cartDetails = value;
      if (onCallback != null) onCallback();
      notifyListeners();
    });
  }

  Future<void> addToCart(AddToCartModel payload, {Function? onCallback}) async {
    if (cartDetails == null) resetStream();

    await _apiService.addToCart(payload).then((cartDetails) {
      if (cartDetails != null) _cartDetails = cartDetails;
      if (onCallback != null) onCallback();
      notifyListeners();
    });
  }

  Future<void> updateQuantity(int productId, int quantity, {Function? onCallback}) async {
    var isProductExists = _cartDetails?.items?.firstWhere((p) => p.id == productId);

    if (isProductExists != null) {
      await _apiService.updateProduct(isProductExists.key.toString(), quantity.toString());
      if (onCallback != null) onCallback();
      updateCartDetails(onCallback: () => notifyListeners());
    }
  }

  Future<void> removeFromCart(int productId, {Function? onCallback}) async {
    var isProductExists = _cartDetails?.items?.firstWhere((p) => p.id == productId);

    if (isProductExists != null) {
      await _apiService.removeProduct(isProductExists.key.toString());
      if (onCallback != null) onCallback();
      updateCartDetails(onCallback: () => notifyListeners());
    }
  }
}
