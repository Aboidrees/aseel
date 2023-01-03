import 'package:aseel/api_service.dart';
import 'package:aseel/models/product_model.dart';
import 'package:flutter/material.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

enum LoadMoreStatus { initial, loading, stable }

class ProductProvider with ChangeNotifier {
  late APIService _apiService;
  late List<ProductModel> _productsList;
  late SortBy _sortBy;
  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.stable;
  int pageSize = 10;

  // getters
  List<ProductModel> get allProducts => _productsList;

  double get totalRecords => _productsList.length.toDouble();

  LoadMoreStatus get loadingStatus => _loadMoreStatus;

  ProductProvider() {
    _sortBy = SortBy('modified', 'الأحدث', "asc");
  }

  void resetStream() {
    _apiService = APIService();
    _productsList = <ProductModel>[];
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
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
    List<ProductModel> products = await _apiService.getProducts(
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
