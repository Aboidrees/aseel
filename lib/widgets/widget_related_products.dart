import 'package:aseel/models/product_model.dart';
import 'package:aseel/services/wc_products_api.dart';
import 'package:aseel/widgets/widget_home_products.dart';
import 'package:aseel/widgets/widget_section_head.dart';
import 'package:flutter/material.dart';

class WidgetRelatedProducts extends StatefulWidget {
  final String labelName;
  final List<int> productsIds;

  const WidgetRelatedProducts({super.key, required this.labelName, required this.productsIds});

  @override
  State<WidgetRelatedProducts> createState() => _WidgetRelatedProductsState();
}

class _WidgetRelatedProductsState extends State<WidgetRelatedProducts> {
  late WCProductsService _wcProductsService;

  @override
  void initState() {
    _wcProductsService = WCProductsService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x0ff4f7fa),
      child: Column(
        children: [
          WidgetSectionHead(headLabel: widget.labelName),
          FutureBuilder(
            future: _wcProductsService.getProducts(productsIds: widget.productsIds),
            builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ProductListItem(products: snapshot.data!);
              }
              return const Center(child: Text("No Data"));
            },
          )
        ],
      ),
    );
  }
}
