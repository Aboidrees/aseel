import 'package:aseel/pages/base.dart';
import 'package:aseel/widgets/widget_product_details.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends BasePage {
  const ProductDetailsPage({super.key});

  @override
  BasePageState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends BasePageState<ProductDetailsPage> {
  @override
  Widget pageUI() => const WidgetProductDetails();
}

class WidgetVariableProduct extends StatelessWidget {
  const WidgetVariableProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
