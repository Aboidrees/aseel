import 'package:aseel/main.dart';
import 'package:aseel/widgets/widget_home_products.dart';
import 'package:aseel/widgets/widget_section_head.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_client/woocommerce_client.dart';

class WidgetRelatedProducts extends StatelessWidget {
  final String labelName;
  final List<int> productsIds;

  const WidgetRelatedProducts({super.key, required this.labelName, required this.productsIds});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x0ff4f7fa),
      child: Column(
        children: [
          WidgetSectionHead(headLabel: labelName),
          FutureBuilder(
            future: woocommerce.productsGet(include: productsIds),
            builder: (context, AsyncSnapshot<List<Product>?> snapshot) {
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
