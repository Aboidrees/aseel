import 'package:aseel/constants/colors.dart';
import 'package:aseel/models/product_model.dart';
import 'package:aseel/widgets/image_display.dart';
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
  const ProductListItem({
    Key? key,
    required this.products,
  }) : super(key: key);

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
        itemBuilder: (context, index) {
          var product = products[index];

          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.width = 130, this.height});

  final ProductModel product;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(1, 2), blurRadius: 5)],
            ),
            child: ImageDisplay(
                imageURL: product.images?[0].url,
                borderRadius: BorderRadius.circular(
                  15,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          //
          ProductPrice(product: product),
        ],
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var sale = double.tryParse(product.salePrice.toString()) ?? 0.0;
    var regular = double.tryParse(product.regularPrice.toString()) ?? double.tryParse(product.price.toString()) ?? 0.0;
    bool productHasSale = regular > sale && sale != 0.0;
    var style = const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold);

    return Visibility(
      visible: sale > 0 || regular > 0,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // regular
            Text("$regular ريال", style: style.copyWith(decoration: productHasSale ? TextDecoration.lineThrough : null)),
            Visibility(visible: productHasSale, child: const SizedBox(width: 4)),
            // sale
            Visibility(
              visible: productHasSale,
              child: Text("${product.salePrice} ريال", style: style.copyWith(color: AppColors.accentColor)),
            ),
          ],
        ),
      ),
    );
  }
}
