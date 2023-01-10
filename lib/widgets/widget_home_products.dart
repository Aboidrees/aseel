import 'package:aseel/models/product_model.dart';
import 'package:aseel/widgets/widget_product_card.dart';
import 'package:aseel/widgets/widget_section_head.dart';
import 'package:flutter/material.dart';

class WidgetHomeProducts extends StatelessWidget {
  final List<ProductModel> products;
  final String labelName;

  const WidgetHomeProducts({super.key, required this.labelName, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x0ff4f7fa),
      child: Column(
        children: [
          WidgetSectionHead(headLabel: labelName),
          ProductListItem(products: products),
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({Key? key, required this.products}) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      alignment: Alignment.centerRight,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
    );
  }
}
