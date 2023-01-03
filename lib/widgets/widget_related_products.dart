import 'package:aseel/api_service.dart';
import 'package:aseel/models/product_model.dart';
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
  late APIService apiService;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x0ff4f7fa),
      child: Column(
        children: [
          WidgetSectionHead(headLabel: widget.labelName),
          _buildProductsNavigation(),
        ],
      ),
    );
  }

  Widget _buildProductsNavigation() {
    return FutureBuilder(
      future: apiService.getProducts(productsIds: widget.productsIds),
      builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ProductNavigation(products: snapshot.data!);
        }
        return const Center(child: Text("No Data"));
      },
    );
  }
}
