import 'package:aseel/main.dart';
import 'package:aseel/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_client/woocommerce_client.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);

  @override
  String toString() => 'SortBy(value: $value, text: $text, sortOrder: $sortOrder)';
}

class ProductProvider with ChangeNotifier {
  LoadingStatus _loadMoreStatus = LoadingStatus.stable;
  LoadingStatus _loadingVariationsStatus = LoadingStatus.stable;

  late List<ProductVariation> _productVariations;
  late List<Product> _productsList;
  late Product _currentProduct;
  late SortBy _sortBy;
  int pageSize = 12;
  // getters
  LoadingStatus get loadVariationsStatus => _loadingVariationsStatus;

  LoadingStatus get loadingMoreStatus => _loadMoreStatus;

  List<ProductVariation> get productVariations => _productVariations;

  List<Product> get allProducts => _productsList;

  Product get currentProduct => _currentProduct;

  double get totalRecords => _productsList.length.toDouble();

  ProductProvider() {
    _sortBy = SortBy('modified', 'Modified', 'asc');
    resetStream();
  }

  void resetStream() {
    _productsList = <Product>[];
    _productVariations = <ProductVariation>[];
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
    // Future.delayed(Duration.zero, () => notifyListeners());
  }

  setCurrentProduct(Product product, {Function? onCallback}) {
    _currentProduct = product;
    if (onCallback != null) onCallback();
    notifyListeners();
  }

  getProductVariations() {
    if (_currentProduct.id == null) return;
    if (_currentProduct.type == ProductTypeEnum.variable) {
      setLoadingVariationsStatus(LoadingStatus.loading);
      woocommerce.productsProductIdVariationsGet(_currentProduct.id!).then((value) {
        if (value != null) {
          _productVariations.clear();
          _productVariations.addAll(value);
          setVariation(value.first);
        }
      });
    }
  }

  setVariation(ProductVariation product, {Function? onCallback}) {
    // setCurrentProduct(_currentProduct.copyWith(
    //   price: product.price,
    //   salePrice: product.salePrice,
    //   regularPrice: product.regularPrice,
    //   images: product.image != null ? [product.image!] : [],
    // ));

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
    String? category,
    String? sortBy,
    String? sortOrder = 'asc',
    Function? onCallback,
  }) async {
    List<Product>? products = await woocommerce.productsGet(
      search: strSearch,
      tag: tagName,
      page: pageNumber,
      perPage: pageSize,
      category: category,
      orderby: _sortBy.value,
      order: _sortBy.sortOrder,
    );

    if (products != null) _productsList.addAll(products);

    setLoadingMoreStatus(LoadingStatus.stable);
    if (onCallback != null) onCallback();
    notifyListeners();
  }
}
