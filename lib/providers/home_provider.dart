import 'package:aseel/config.dart';
import 'package:aseel/main.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_client/woocommerce_client.dart';

class HomeProvider with ChangeNotifier {
  late List<ProductCat> _categories = [];

  late List<Product> _offers;
  late List<Product> _topRated;
  late List<Product> _topSelling;
  late List<Product> _newArrival;

  List<ProductCat> get categories => _categories;
  List<Product> get offers => _offers;
  List<Product> get topRated => _topRated;
  List<Product> get topSelling => _topSelling;
  List<Product> get newArrival => _newArrival;

  HomeProvider() {
    resetStream();
    _initialize();
  }

  resetStream() {
    _categories = <ProductCat>[];
    _offers = <Product>[];
    _topRated = <Product>[];
    _topSelling = <Product>[];
    _newArrival = <Product>[];
  }

  _initialize() {
    getCategories();
    getOffers();
    getNewArrival();
    getTopSelling();
  }

  Future getCategories() async {
    woocommerce.productsCategoriesGet().then((value) {
      _categories.addAll(value ?? []);
      notifyListeners();
    });
  }

  Future getOffers() async {
    woocommerce.productsGet(tag: Config.offersTag).then((value) {
      _offers.addAll(value ?? []);
      notifyListeners();
    });
  }

  Future getNewArrival() async {
    woocommerce.productsGet(tag: Config.newArrivalTag).then((value) {
      _newArrival.addAll(value ?? []);
      notifyListeners();
    });
  }

  Future getTopSelling() async {
    woocommerce.productsGet(tag: Config.topSellTag).then((value) {
      _topSelling.addAll(value ?? []);
      notifyListeners();
    });
  }
}
