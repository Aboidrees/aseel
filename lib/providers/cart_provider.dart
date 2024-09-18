import 'package:aseel/main.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_client/woocommerce_client.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class CartProvider with ChangeNotifier {
  late ShopOrder? _cartDetails;

  double get totalRecords => _cartDetails?.lineItems.length.toDouble() ?? 0.0;

  double get totalAmount => _cartDetails?.lineItems?.isNotEmpty ?? false
      ? _cartDetails?.lineItems.map((e) => (e.quantity ?? 0) * (e.price?.toDouble() ?? 0) / 100).reduce((sum, nextValue) => sum += nextValue) ?? 0.0
      : 0.0;

  List<ShopOrder1LineItemsInner> get items => _cartDetails?.lineItems ?? [];

  CartProvider() {
    _cartDetails = ShopOrder();
    // updateCartDetails();
    notifyListeners();
  }

  ShopOrder? get cartDetails => _cartDetails;

  resetStream() => _cartDetails = ShopOrder();

  Future<void> updateCartDetails({Function? onCallback}) async {
    // if (cartDetails == null) resetStream();
    //
    // woocommerce_api.getCart().then((value) {
    //
    //   _cartDetails = value;
    //   if (onCallback != null) onCallback();
    //   notifyListeners();
    // });
  }

  Future<void> addToCart(ShopOrder1LineItemsInner payload, {Function? onCallback}) async {
    if (cartDetails == null) resetStream();
    _cartDetails?.lineItems.add(payload  );

    if (onCallback != null) onCallback();
    notifyListeners();
    }

  Future<void> updateQuantity(int productId, int quantity, {Function? onCallback}) async {
    var isProductExists = _cartDetails?.lineItems.firstWhere((p) => p.id == productId);

    if (isProductExists != null) {
      if (onCallback != null) onCallback();
      updateCartDetails(onCallback: () => notifyListeners());
    }
  }

  Future<void> removeFromCart(int productId, {Function? onCallback}) async {
    var isProductExists = _cartDetails?.lineItems?.firstWhere((p) => p.id == productId);

    if (isProductExists != null) {
      if (onCallback != null) onCallback();
      updateCartDetails(onCallback: () => notifyListeners());
    }
  }
}
