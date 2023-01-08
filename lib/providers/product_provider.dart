import 'package:aseel/models/product_model.dart';
import 'package:aseel/services/wc_products_api.dart';
import 'package:flutter/material.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

enum LoadMoreStatus { initial, loading, stable }

class ProductProvider with ChangeNotifier {
  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.stable;
  late WCProductsService _wcProductsService;
  late List<ProductModel> _productVariations;
  late List<ProductModel> _productsList;
  late ProductModel _currentProduct;
  late SortBy _sortBy;
  int pageSize = 9;

  // getters
  List<ProductModel> get allProducts => _productsList;

  double get totalRecords => _productsList.length.toDouble();

  LoadMoreStatus get loadingStatus => _loadMoreStatus;

  ProductProvider() {
    _sortBy = SortBy('modified', 'الأحدث', "asc");
  }

  void resetStream() {
    _wcProductsService = WCProductsService();
    _productsList = <ProductModel>[];
    _productVariations = <ProductModel>[];
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) => _loadMoreStatus = loadMoreStatus;

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  ProductModel get currentProduct => _currentProduct;

  List<ProductModel> get productVariations => _productVariations;

  setCurrentProduct(ProductModel product, {Function? onCallback}) async {
    _currentProduct = product;
    if (product.type == 'variable') {
      // print(product);
      await _wcProductsService.getVariableProduct(product.id)?.then((value) {
        if (value.isNotEmpty) {
          _productVariations = [];
          _productVariations.addAll(value);
          if (onCallback != null) onCallback();
          notifyListeners();
        }
      });
    }
  }

  loadProductVariations() {}

  fetchProducts(
    int pageNumber, {
    String? strSearch,
    String? tagName,
    String? categoryId,
    String? sortBy,
    String? sortOrder = 'asc',
    Function? onCallback,
  }) async {
    List<ProductModel> products = await _wcProductsService.getProducts(
      strSearch: strSearch,
      tagName: tagName,
      pageNumber: pageNumber,
      pageSize: pageSize,
      categoryId: categoryId,
      sortBy: _sortBy.value,
      sortOrder: _sortBy.sortOrder,
    );

    if (products.isNotEmpty) _productsList.addAll(products);

    setLoadingState(LoadMoreStatus.stable);
    if (onCallback != null) onCallback();
    notifyListeners();
  }
}
