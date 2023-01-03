import 'package:aseel/models/product_model.dart';
import 'package:aseel/pages/base.dart';
import 'package:aseel/widgets/widget_product_details.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends BasePage {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  BasePageState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends BasePageState<ProductDetailsPage> {
  // TODO: move the current project to provider
  @override
  Widget pageUI() => WidgetProductDetails(product: widget.product);
}
