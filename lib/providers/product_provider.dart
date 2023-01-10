import 'package:aseel/models/product_model.dart';
import 'package:aseel/services/wc_products_api.dart';
import 'package:aseel/utils/enums.dart';
import 'package:flutter/material.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

class ProductProvider with ChangeNotifier {
  LoadingStatus _loadMoreStatus = LoadingStatus.stable;
  LoadingStatus _loadingVariationsStatus = LoadingStatus.stable;

  late WCProductsService _wcProductsService;
  late List<ProductModel> _productVariations;
  late List<ProductModel> _productsList;
  late ProductModel _currentProduct;
  late SortBy _sortBy;
  int pageSize = 12;

  // getters
  LoadingStatus get loadVariationsStatus => _loadingVariationsStatus;

  LoadingStatus get loadingMoreStatus => _loadMoreStatus;

  List<ProductModel> get productVariations => _productVariations;

  List<ProductModel> get allProducts => _productsList;

  ProductModel get currentProduct => _currentProduct;

  double get totalRecords => _productsList.length.toDouble();

  ProductProvider() {
    _sortBy = SortBy('modified', 'الأحدث', "asc");
  }

  void resetStream() {
    _wcProductsService = WCProductsService();
    _productsList = <ProductModel>[];
    _productVariations = <ProductModel>[];
  }

  setLoadingMoreStatus(LoadingStatus loadingStatus) {
    _loadMoreStatus = loadingStatus;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  setLoadingVariationsStatus(LoadingStatus loadingStatus) {
    _loadingVariationsStatus = loadingStatus;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  setCurrentProduct(ProductModel product, {Function? onCallback}) {
    _currentProduct = product;
    if (onCallback != null) onCallback();
    notifyListeners();
  }

  getProductVariations() {
    if (_currentProduct.type == 'variable') {
      setLoadingVariationsStatus(LoadingStatus.loading);
      _wcProductsService.getVariableProduct(_currentProduct.id)?.then((value) {
        if (value.isNotEmpty) {
          _productVariations = [];
          _productVariations.addAll(value);
          setVariation(value[0]);
        }
      });
    }
  }

  setVariation(ProductModel product, {Function? onCallback}) {
    setCurrentProduct(_currentProduct.copyWith(
      price: product.price,
      salePrice: product.salePrice,
      regularPrice: product.regularPrice,
      images: product.image != null ? [product.image!] : [],
    ));

    setLoadingVariationsStatus(LoadingStatus.stable);
    if (onCallback != null) onCallback();

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

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

    setLoadingMoreStatus(LoadingStatus.stable);
    if (onCallback != null) onCallback();
    notifyListeners();
  }
}
