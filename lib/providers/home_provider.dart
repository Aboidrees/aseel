import 'package:aseel/config.dart';
import 'package:aseel/models/category.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/services/wc_categories_api.dart';
import 'package:aseel/services/wc_products_api.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  late WCCategoriesService _wcCategoriesService;
  late WCProductsService _wcProductsService;

  late List<CategoryModel> _categories = [];
  late List<ProductModel> _offers;
  late List<ProductModel> _topRated;
  late List<ProductModel> _topSelling;
  late List<ProductModel> _newArrival;

  List<CategoryModel> get categories => _categories;
  List<ProductModel> get offers => _offers;
  List<ProductModel> get topRated => _topRated;
  List<ProductModel> get topSelling => _topSelling;
  List<ProductModel> get newArrival => _newArrival;

  HomeProvider() {
    // _wcProductsService.getProducts(tagName: Config.offersTag).then(_offers.addAll);
    // _wcProductsService.getProducts(tagName: Config.topSellTag).then(_topRated.addAll);
    // // _wcProductsService.getProducts(tagName: "").then(_topSaled.addAll);
    // _wcProductsService.getProducts(tagName: Config.newArrivalTag).then(_latest.addAll);

    resetStream();
    _initialize();
  }

  resetStream() {
    _wcCategoriesService = WCCategoriesService();
    _wcProductsService = WCProductsService();

    _categories = <CategoryModel>[];

    _offers = <ProductModel>[];
    _topRated = <ProductModel>[];
    _topSelling = <ProductModel>[];
    _newArrival = <ProductModel>[];
  }

  _initialize() {
    getCategories();
    getOffers();
    getNewArrival();
    getTopSalling();
  }

  Future getCategories() async {
    _wcCategoriesService.getCategories().then((value) {
      if (value.isNotEmpty) {
        _categories.addAll(value);
        notifyListeners();
      }
    });
  }

  Future getOffers() async {
    _wcProductsService.getProducts(tagName: Config.offersTag).then((value) {
      if (value.isNotEmpty) {
        _offers.addAll(value);
        notifyListeners();
      }
    });
  }

  Future getNewArrival() async {
    _wcProductsService.getProducts(tagName: Config.newArrivalTag).then((value) {
      if (value.isNotEmpty) {
        _newArrival.addAll(value);
        notifyListeners();
      }
    });
  }

  Future getTopSalling() async {
    _wcProductsService.getProducts(tagName: Config.topSellTag).then((value) {
      if (value.isNotEmpty) {
        _topSelling.addAll(value);
        notifyListeners();
      }
    });
  }
}
